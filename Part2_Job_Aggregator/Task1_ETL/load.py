import pandas as pd
from sqlalchemy import create_engine
import urllib
from transform import transform_data

SERVER_NAME = r'DESKTOP-EU0USCO\SQLEXPRESS'
DATABASE_NAME = 'Part2'

params = urllib.parse.quote_plus(
    f"DRIVER={{ODBC Driver 17 for SQL Server}};"
    f"SERVER={SERVER_NAME};"
    f"DATABASE={DATABASE_NAME};"
    f"Trusted_Connection=yes;"
)

engine = create_engine(f"mssql+pyodbc:///?odbc_connect={params}")

def load_to_sql_server():
    fact_jobs, dim_locations, dim_occupations, dim_skills = transform_data()

    print("1. Joylashuvlar (dim_locations) yuklanmoqda...")
    dim_locations.to_sql('dim_locations', con=engine, if_exists='replace', index=False)

    print("2. Kasblar (dim_occupations) yuklanmoqda...")
    dim_occupations.to_sql('dim_occupations', con=engine, if_exists='replace', index=False)

    print("3. Ko'nikmalar (dim_skills) yuklanmoqda...")
    dim_skills.to_sql('dim_skills', con=engine, if_exists='replace', index=False)

    print("4. Asosiy e'lonlar (fact_jobs) yuklanmoqda...")
    fact_jobs.to_sql('fact_jobs', con=engine, if_exists='replace', index=False)

if __name__ == "__main__":
    load_to_sql_server()