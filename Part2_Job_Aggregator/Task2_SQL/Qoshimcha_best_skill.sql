SELECT TOP 10
    s.skill_name,
    COUNT(js.job_id) AS talab_soni,
    AVG(f.job_salary) AS ortacha_maosh
FROM dbo.fact_job_skills js
JOIN dbo.dim_skills s ON js.skill_id = s.skill_id
JOIN dbo.fact_jobs f ON js.job_id = f.job_id
WHERE s.skill_name IS NOT NULL 
  AND s.skill_name NOT LIKE '%?%'
GROUP BY s.skill_name
HAVING COUNT(js.job_id) > 1
ORDER BY talab_soni DESC;