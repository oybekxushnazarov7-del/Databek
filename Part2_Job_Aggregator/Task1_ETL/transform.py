import pandas as pd 
from pathlib import Path

DATA_DIR = Path("Part2_Job_Aggregator/Task1_ETL/jobgram_org_2025")
def transform_data():
    jobs = pd.read_csv(DATA_DIR / "jobs.csv")
    skills = pd.read_csv(DATA_DIR / "requirement_skills.csv")
    locations = pd.read_csv(DATA_DIR / "job_locations.csv")
    occupations = pd.read_csv(DATA_DIR / "occupations.csv")

    jobs['job_salary'] = pd.to_numeric(jobs['job_salary'], errors = 'coerce')
    ortacha_maosh = jobs['job_salary'].mean()
    jobs['job_salary'] = jobs['job_salary'].fillna(ortacha_maosh)
    jobs['created_at'] = pd.to_datetime(jobs['created_at'], errors = 'coerce')

    #SKILLS
    skills['skill'] = skills['skill'].astype(str).str.split(',')
    skills_transformed = skills.explode('skill')
    skills_transformed['skill'] = skills_transformed['skill'].str.strip()

    # dim 
    dim_locations = locations.drop_duplicates().reset_index(drop=True)
    dim_occupations = occupations.drop_duplicates().reset_index(drop=True)

    dim_skills = skills_transformed[['skill']].drop_duplicates().reset_index(drop=True)
    dim_skills['skill_id'] = dim_skills.index + 1
    dim_skills.rename(columns={'skill': 'skill_name'}, inplace=True)
    dim_skills = dim_skills[['skill_id', 'skill_name']]

    fact_jobs = jobs[['id', 'job_name', 'company_name', 'job_type', 'job_salary', 'created_at']].copy()
    fact_jobs.rename(columns={'id': 'job_id'}, inplace=True)

    print("Transform muvaffaqiyatli yakunlandi!")
    return fact_jobs, dim_locations, dim_occupations, dim_skills

if __name__ == "__main__":
    fact_jobs, dim_locations, dim_occupations, dim_skills = transform_data()
    print("Tozalangan Fact Jobs")
    print(fact_jobs.head(100))