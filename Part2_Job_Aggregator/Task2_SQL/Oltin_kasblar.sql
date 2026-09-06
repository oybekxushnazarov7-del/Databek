select top 5
	o.occupation,
	count(f.job_id) as vakansiyalar_soni,
	max(f.job_salary) as eng_baland_maosh
from fact_jobs f
Join dim_occupations o  ON f.job_id = o.job_id
where o.occupation not like '%?%'
Group by o.occupation
having count(f.job_id) > 1 
order by eng_baland_maosh desc, vakansiyalar_soni asc
