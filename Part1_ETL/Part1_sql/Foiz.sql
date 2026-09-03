select status, count(*) as abituriyentlar_soni, round(count(*)*100.0/ (select count(*) from abituriyent_2024), 2) as foiz
from abituriyent_2024
Group By status  