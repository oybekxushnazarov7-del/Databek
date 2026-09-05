select top 5 skill_name, count(*) as talab_soni
from dim_skills
group by skill_name
order by talab_soni desc 