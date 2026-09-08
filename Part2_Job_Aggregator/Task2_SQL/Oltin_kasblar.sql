SELECT TOP 5
    o.occupation_name,
    COUNT(f.job_id) AS vakansiyalar_soni,
    AVG(f.job_salary) AS ortacha_maosh
FROM dbo.fact_jobs f
JOIN dbo.dim_occupations o ON f.occupation_id = o.occupation_id
WHERE f.job_salary IS NOT NULL
GROUP BY o.occupation_name
HAVING COUNT(f.job_id) >= 1
ORDER BY ortacha_maosh DESC, vakansiyalar_soni ASC;