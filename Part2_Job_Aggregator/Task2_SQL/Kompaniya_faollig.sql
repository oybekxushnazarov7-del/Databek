select top 5
	f.company_name,
	count(f.job_id) as vakansiyalar_soni,
	max(f.job_salary) as eng_baland_maosh
from fact_jobs f
where f.company_name not like '%?%'
Group by f.company_name
having count(f.job_id) > 5 
order by eng_baland_maosh desc, vakansiyalar_soni asc
