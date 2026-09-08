import pandas as pd
from pathlib import Path

DATA_DIR = Path("Part2_Job_Aggregator/Task1_ETL/jobgram_org_2025")

def extract_data():
    raw_data = {}
    
    for file_path in DATA_DIR.glob("*.csv"):
        name = file_path.stem
        raw_data[name] = pd.read_csv(file_path, encoding='utf-8', encoding_errors='replace')
            
    return raw_data

if __name__ == "__main__":
    data = extract_data()
    print("O'qilgan jadvallar:", list(data.keys()))