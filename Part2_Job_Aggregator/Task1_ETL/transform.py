import re
import pandas as pd
from extract import extract_data

EXCHANGE_RATES = {
    'UZS': 1.0,
    'USD': 12800.0,
    'RUB': 140.0
}

def clean_text(text):
    if pd.isna(text):
        return None
    val = str(text).strip()
    if not val or set(val) == {'?'}:
        return None
    return val

def parse_salary_row(val):
    if pd.isna(val) or not str(val).strip():
        return pd.Series([None, None, 'UZS', False, None])
    
    val_str = str(val).lower().strip()
    
    keywords = ['kelish', 'shartlash', 'negotiable', 'specified', 'suhbat', 'belgilanmagan']
    is_negotiable = any(kw in val_str for kw in keywords)
    
    currency = 'UZS'
    if 'usd' in val_str or '$' in val_str or 'dollar' in val_str:
        currency = 'USD'
    elif 'rub' in val_str or 'руб' in val_str or 'rubles' in val_str or ' р ' in val_str:
        currency = 'RUB'
    
    has_mln = 'mln' in val_str or 'million' in val_str or 'миллион' in val_str
    
    # Probellar va probel kabi belgilarni to'g'irlaymiz
    clean_val = val_str.replace('\xa0', ' ').replace(',', '.')
    
    # Raqamlar oralig'ini topamiz
    numbers = [float(n) for n in re.findall(r'\d+(?:\.\d+)?', clean_val)]
    
    if not numbers:
        return pd.Series([None, None, currency, is_negotiable, None])
    
    if has_mln:
        numbers = [n * 1_000_000 if n < 1000 else n for n in numbers]
        
    if len(numbers) >= 2:
        sal_min = numbers[0]
        sal_max = numbers[1]
    else:
        sal_min = numbers[0]
        sal_max = numbers[0]
        
    rate = EXCHANGE_RATES.get(currency, 1.0)
    avg_uzs = ((sal_min * rate) + (sal_max * rate)) / 2.0
    
    return pd.Series([sal_min, sal_max, currency, is_negotiable, avg_uzs])

def transform_data():
    raw_data = extract_data()
    
    jobs = raw_data['jobs'].copy()
    skills = raw_data['requirement_skills'].copy()
    locations = raw_data['job_locations'].copy()
    occupations = raw_data['occupations'].copy()
    channels = raw_data['channels'].copy()

    # Maoshlarni parsing qilish
    salary_data = jobs['job_salary'].apply(parse_salary_row)
    salary_data.columns = [
        'salary_min', 
        'salary_max', 
        'salary_currency', 
        'salary_is_negotiable', 
        'salary_avg_uzs'
    ]
    
    jobs = pd.concat([jobs, salary_data], axis=1)

    if 'occupation_id' in jobs.columns:
        occ_avg = jobs.groupby('occupation_id')['salary_avg_uzs'].transform('mean')
        jobs['salary_avg_uzs'] = jobs['salary_avg_uzs'].fillna(occ_avg)
    
    tot_avg = jobs['salary_avg_uzs'].mean()
    jobs['job_salary'] = jobs['salary_avg_uzs'].fillna(tot_avg)

    jobs['created_at'] = pd.to_datetime(jobs['created_at'], errors='coerce').dt.date

    # Channels
    channels['created_at'] = pd.to_datetime(channels['created_at'], errors='coerce').dt.date
    channels['updated_at'] = pd.to_datetime(channels['updated_at'], errors='coerce').dt.date
    dim_channels = channels.drop_duplicates(subset=['id']).reset_index(drop=True)

    # Locations
    locations['city'] = locations['city'].apply(clean_text).str.slice(0, 255)
    locations['country'] = locations['country'].apply(clean_text).str.slice(0, 255)
    
    dim_locations = locations[['country_code', 'country', 'city']].drop_duplicates().dropna(subset=['city']).reset_index(drop=True)
    dim_locations['location_id'] = dim_locations.index + 1
    dim_locations = dim_locations[['location_id', 'country_code', 'country', 'city']]

    loc_mapped = locations.merge(dim_locations, on=['country_code', 'country', 'city'], how='left')
    job_location_map = loc_mapped[['job_id', 'location_id']].drop_duplicates(subset=['job_id'])

    # Occupations
    occupations['occupation'] = occupations['occupation'].apply(clean_text)
    dim_occupations = occupations[['occupation']].drop_duplicates().dropna(subset=['occupation']).reset_index(drop=True)
    dim_occupations['occupation_id'] = dim_occupations.index + 1
    dim_occupations.rename(columns={'occupation': 'occupation_name'}, inplace=True)
    dim_occupations = dim_occupations[['occupation_id', 'occupation_name']]

    occ_mapped = occupations.merge(dim_occupations, left_on='occupation', right_on='occupation_name', how='left')
    job_occupation_map = occ_mapped[['job_id', 'occupation_id']].drop_duplicates(subset=['job_id'])

    # Skills
    skills['skill'] = skills['skill'].astype(str).str.split(',')
    skills_exp = skills.explode('skill')
    skills_exp['skill'] = skills_exp['skill'].apply(clean_text)
    skills_exp = skills_exp.dropna(subset=['skill'])
    skills_exp['skill'] = skills_exp['skill'].str.strip()

    dim_skills = skills_exp[['skill']].drop_duplicates().reset_index(drop=True)
    dim_skills['skill_id'] = dim_skills.index + 1
    dim_skills.rename(columns={'skill': 'skill_name'}, inplace=True)
    dim_skills = dim_skills[['skill_id', 'skill_name']]

    fact_job_skills = skills_exp.merge(dim_skills, left_on='skill', right_on='skill_name', how='inner')
    fact_job_skills = fact_job_skills[['job_id', 'skill_id']].drop_duplicates().reset_index(drop=True)

    # Fact Jobs
    fact_jobs = jobs[[
        'id', 
        'job_name', 
        'company_name', 
        'job_type', 
        'job_salary',
        'salary_min', 
        'salary_max', 
        'salary_currency', 
        'salary_is_negotiable',
        'created_at'
    ]].copy()
    
    fact_jobs.rename(columns={'id': 'job_id'}, inplace=True)
    fact_jobs = fact_jobs.merge(job_location_map, on='job_id', how='left')
    fact_jobs = fact_jobs.merge(job_occupation_map, on='job_id', how='left')

    return {
        'fact_jobs': fact_jobs,
        'fact_job_skills': fact_job_skills,
        'dim_locations': dim_locations,
        'dim_occupations': dim_occupations,
        'dim_skills': dim_skills,
        'dim_channels': dim_channels
    }

if __name__ == "__main__":
    transformed = transform_data()
    print("Transform bajarildi:", list(transformed.keys()))