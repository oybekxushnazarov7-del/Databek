import csv 
import glob
import os 
import pyodbc

folder_path = './mandat_uzbmb_uz_2025'
csv_files = glob.glob(os.path.join(folder_path, '*.csv'))
print(f"Jami {len(csv_files)} ta CSV fayllar topildi.")

#data cleaning
cleaned_data = []
for file in csv_files:
    with open(file, 'r', encoding='utf-8-sig') as f:
        reader = csv.DictReader(f)
        for row in reader:
            tr_class = (row.get('TR class') or '').strip().lower()
            if 'table-success' in tr_class:
                status = 'Grant'
            elif 'table-warning' in tr_class:
                status = 'Kontrakt'
            else:
                status = 'Yiqilgan'

            raw_ball = row.get('Ball', '0')
            try :
                ball = float(raw_ball.replace(',', '.'))
            except ValueError:
                ball = 0.0

            row_clean = {
                'TR_class': row.get('TR class', ''),
                'Status': status ,
                'Ball': ball,
                'oliy_talim_muassasasi': row.get('Oliy ta\'lim muassasasi', ''),
                'FIO': row.get('F.I.SH', ''),
                'yonalish':row.get("Yo'nalish",''),
                'til':row.get("Ta'lim tili")
            }
            cleaned_data.append(row_clean)

print(f"Jami {len(cleaned_data)} ta qator tozalandi")



SERVER = '.\\SQLEXPRESS'
DATABASE = 'HR'
DRIVER = '{ODBC Driver 17 for SQL Server}'

conn_str = f"DRIVER={DRIVER};SERVER={SERVER};DATABASE={DATABASE};Trusted_Connection=yes;"

try:
    conn = pyodbc.connect(conn_str)
    cursor = conn.cursor()

    cursor.fast_executemany = True

    insert_query = """
        insert into abituriyent_2024 (tr_class, status, ball,oliy_talim_muassasasi,FIO,yonalish,til)
        values (?, ?, ?,?,?,?,?)
    """
    records_to_insert = [
        (item['TR_class'], item['Status'], item['Ball'],item['oliy_talim_muassasasi'],item['FIO'],item['yonalish'],item['til'])
        for item in cleaned_data
    ]

    cursor.executemany(insert_query, records_to_insert)
    conn.commit()

    print("Ma'lumotlar SQL SERVER dagi 'abituriyent_2024' jadvaliga yuklandi")

except Exception as e:
    print("Xatolik: ", e)

finally:
    if 'conn' in locals():
        conn.close()