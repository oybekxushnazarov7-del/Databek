SELECT 
    FIO,
    yonalish,
    oliy_talim_muassasasi,
    ball,
    status
FROM (
    SELECT 
        FIO,
        yonalish,
        oliy_talim_muassasasi,
        ball,
        status,
        ROW_NUMBER() OVER (PARTITION BY yonalish ORDER BY ball DESC) as rn
    FROM abituriyent_2024
) t
WHERE t.rn = 1;