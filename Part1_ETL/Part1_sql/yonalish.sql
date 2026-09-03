SELECT
    FIO as OMADSIZLAR,
    yonalish,
    oliy_talim_muassasasi,
    ball,
    status
FROM abituriyent_2024
WHERE status = 'Yiqilgan' OR tr_class LIKE '%table-secondary%'
ORDER BY ball DESC;