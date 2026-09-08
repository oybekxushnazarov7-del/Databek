SELECT TOP 5 
    s.skill_name, 
    COUNT(fjs.job_id) AS talab_soni
FROM dbo.fact_job_skills fjs
JOIN dbo.dim_skills s ON fjs.skill_id = s.skill_id
GROUP BY s.skill_id, s.skill_name
ORDER BY talab_soni DESC;