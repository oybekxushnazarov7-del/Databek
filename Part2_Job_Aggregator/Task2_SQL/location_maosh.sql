SELECT 
    CASE 
        WHEN LOWER(l.city) LIKE '%toshkent%' OR LOWER(l.city) LIKE '%tashkent%' THEN 'Toshkent'
        ELSE 'Viloyat'
    END AS hudud,
    COUNT(f.job_id) AS vakansiyalar_soni,
    AVG(f.job_salary) AS ortacha_maosh
FROM dbo.fact_jobs f
JOIN dbo.dim_locations l ON f.location_id = l.location_id
WHERE l.city IS NOT NULL
GROUP BY 
    CASE 
        WHEN LOWER(l.city) LIKE '%toshkent%' OR LOWER(l.city) LIKE '%tashkent%' THEN 'Toshkent'
        ELSE 'Viloyat'
    END;


WITH MaxDate AS (
    SELECT MAX(created_at) AS max_created_at FROM dbo.fact_jobs
)
SELECT TOP 10
    l.city,
    COUNT(f.job_id) AS jami_vakansiyalar,
    AVG(f.job_salary) AS ortacha_maosh,
    COUNT(CASE WHEN f.created_at >= DATEADD(month, -6, m.max_created_at) THEN 1 END) AS oxirgi_yarm_yildagi_vakansiyalar
FROM dbo.fact_jobs f
JOIN dbo.dim_locations l ON f.location_id = l.location_id
CROSS JOIN MaxDate m
WHERE l.city IS NOT NULL 
  AND l.city NOT LIKE '%?%' 
  AND l.city <> ''
GROUP BY l.city, m.max_created_at
ORDER BY jami_vakansiyalar DESC;