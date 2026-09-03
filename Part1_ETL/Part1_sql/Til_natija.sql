SELECT 
    til,
    COUNT(*) AS grant_olganlar_soni,
    ROUND(AVG(ball), 2) AS ortacha_grant_bali,
    MAX(ball) AS eng_yuqori_ball,
    MIN(ball) AS eng_paski_grant_bali
FROM abituriyent_2024
WHERE status = 'Grant' 
  AND (til LIKE '%zbek%' OR til LIKE '%усс%')
GROUP BY til;