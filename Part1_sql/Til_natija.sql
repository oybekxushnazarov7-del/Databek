select til, count(*) as umumiy_abituriyentlar,
    count(case when status = 'Grant' THEN 1 END) as grand_olganlar_soni,
    round(count(case when status = 'Grant' THEN 1 END)*100.0 / Count(*),2) as grant_foizi,
    round(avg(ball), 2) as ortacha_ball,
    MAX(ball) as eng_yuqori_ball,
    MIN(ball) as eng_past_ball
FROM abituriyent_2024
WHERE til LIKE '%zbek%' OR til LIKE '%Русс%'
GROUP BY til;