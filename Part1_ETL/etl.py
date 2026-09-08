import glob
import os 
import pyodbc
import pandas as pd
from dotenv import load_dotenv

load_dotenv()

folder_path = 'Part1_ETL/mandat_uzbmb_uz_2025'
csv_files = glob.glob(os.path.join(folder_path, '*.csv'))
print(f"Jami {len(csv_files)} ta CSV fayllar topildi.")


df_list = []
for file in csv_files:
    temp_df = pd.read_csv(file, encoding = "utf-8-sig", dtype = str)
    df_list.append(temp_df)

df = pd.concat(df_list, ignore_index=True)

def get_status(tr_class):
    tr = str(tr_class).lower()
    if "table-success" in tr:
        return "Grant"
    elif "table-warning" in tr:
        return "Kontrakt"
    return "Yiqilgan"

df["Status"] = df["TR class"].apply(get_status)

df["Ball"] = (
    df["Ball"].astype(str).str.replace(",", ".", regex = False)
    .apply(pd.to_numeric, errors = "coerce").fillna(0.0)
)

df_clean = pd.DataFrame(
    {
        "ID": df.get("ID", None),
        "TR_class": df.get("TR class", ""),
        "Status": df["Status"],
        "Ball": df["Ball"],
        "oliy_talim_muassasasi": df.get("Oliy ta'lim muassasasi", ""),
        "FIO": df.get("F.I.SH", ""),
        "yonalish": df.get("Yo'nalish", ""),
        "talim_shakli": df.get("Ta'lim shakli", ""),
        "til": df.get("Ta'lim tili", ""),
    }
)

df_clean = df_clean.drop_duplicates(subset = ["ID"])
df_clean = df_clean.fillna("")
print(f"Jami  {len(df_clean)} ta toza qilindi va birlashtirildi")



SERVER = os.getenv("DB_SERVER")
DATABASE = os.getenv("DB_DATABASE")
USERNAME = os.getenv("DB_USERNAME")
PASSWORD = os.getenv("DB_PASSWORD")
DRIVER = os.getenv("DB_DRIVER")

conn_str = (
    f"DRIVER={DRIVER};"
    f"SERVER={SERVER};"
    f"DATABASE={DATABASE};"
    f"UID={USERNAME};"
    f"PWD={PASSWORD};"
    "Encrypt=yes;"
    "TrustServerCertificate=no;"
)

try:
    conn = pyodbc.connect(conn_str)
    cursor = conn.cursor()

    cursor.fast_executemany = True

    insert_query = """
        insert into abituriyent_2024 (ID,tr_class, status, ball,oliy_talim_muassasasi,FIO,yonalish,talim_shakli,til)
        values (?,?,?,?,?,?,?,?,?)
    """

    records_to_insert = list(df_clean.itertuples(index=False, name=None))

    cursor.executemany(insert_query, records_to_insert)
    conn.commit()

    print("Ma'lumotlar SQL SERVER dagi 'abituriyent_2024' jadvaliga yuklandi")

except Exception as e:
    print("Xatolik: ", e)

finally:
    if 'conn' in locals():
        conn.close()