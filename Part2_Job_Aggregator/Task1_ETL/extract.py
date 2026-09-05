import pandas as pd 
from pathlib import Path
DATA_DIR = Path("Part2_Job_Aggregator/Task1_ETL/jobgram_org_2025")

data = {}
for file in DATA_DIR.glob("*.csv"):
    name = file.stem
    data[name] = pd.read_csv(file)
    print(f"{name} fayli o'qildi")

print(data["jobs"].head())