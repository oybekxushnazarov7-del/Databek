SELECT TOP 10
    c.title AS kanal_nomi,
    COUNT(f.job_id) AS vakansiyalar_soni,
    AVG(f.job_salary) AS ortacha_maosh
FROM dbo.fact_jobs f
JOIN dbo.dim_channels c ON f.job_id = c.id
WHERE c.title IS NOT NULL
GROUP BY c.title
ORDER BY vakansiyalar_soni DESC;

SELECT TOP 10
    f.company_name,
    COUNT(f.job_id) AS vakansiyalar_soni,
    AVG(f.job_salary) AS ortacha_maosh
FROM dbo.fact_jobs f
WHERE f.company_name IS NOT NULL 
  AND f.company_name NOT LIKE '%?%'
GROUP BY f.company_name
HAVING COUNT(f.job_id) > 1
ORDER BY vakansiyalar_soni DESC;