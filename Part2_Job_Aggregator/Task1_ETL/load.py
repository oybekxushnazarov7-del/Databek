import urllib
import pandas as pd
from sqlalchemy import create_engine
from transform import transform_data

SERVER_NAME = r'DESKTOP-EU0USCO\SQLEXPRESS'
DATABASE_NAME = 'Part2'

params = urllib.parse.quote_plus(
    f"DRIVER={{ODBC Driver 17 for SQL Server}};"
    f"SERVER={SERVER_NAME};"
    f"DATABASE={DATABASE_NAME};"
    f"Trusted_Connection=yes;"
)

engine = create_engine(f"mssql+pyodbc:///?odbc_connect={params}", fast_executemany=True)

def load_to_sql_server():
    data = transform_data()

    load_order = [
        ('dim_locations', data['dim_locations']),
        ('dim_occupations', data['dim_occupations']),
        ('dim_skills', data['dim_skills']),
        ('dim_channels', data['dim_channels']),
        ('fact_jobs', data['fact_jobs']),
        ('fact_job_skills', data['fact_job_skills'])
    ]

    for table_name, df in load_order:
        df.to_sql(
            name=table_name, 
            con=engine, 
            if_exists='append', 
            index=False,
            chunksize=1000
        )

if __name__ == "__main__":
    load_to_sql_server()