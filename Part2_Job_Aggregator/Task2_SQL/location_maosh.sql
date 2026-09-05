select
	l.city, avg(f.job_salary) as ortacha_maosh,
	count(f.job_id) as vakansiyalar_soni 
	from fact_jobs f
	join dim_locations l ON f.job_id = l.job_id
	group by city
	order by ortacha_maosh desc;