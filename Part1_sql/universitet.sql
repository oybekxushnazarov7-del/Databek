select oliy_talim_muassasasi, 
AVG(ball) as ortacha_grant_bali, 
count(*) as grantlar_soni 
from abituriyent_2024
where status = 'Grant'
Group by oliy_talim_muassasasi
Order by ortacha_grant_bali desc