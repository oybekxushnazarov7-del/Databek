SELECT 'A' as Parent, 'Male' as ChildGender INTO tblPerson
UNION ALL
SELECT 'A' as Parent, 'Male' as ChildGender
UNION ALL
SELECT 'A' as Parent, 'Female' as ChildGender
UNION ALL
SELECT 'A' as Parent, 'Male' as ChildGender
UNION ALL
SELECT 'A' as Parent, 'Female' as ChildGender
UNION ALL
SELECT 'B' as Parent, 'Male' as ChildGender
UNION ALL
SELECT 'B' as Parent, 'Male' as ChildGender
UNION ALL
SELECT 'B' as Parent, 'Male' as ChildGender
UNION ALL
SELECT 'C' as Parent, 'Female' as ChildGender
UNION ALL
SELECT 'C' as Parent, 'Male' as ChildGender
UNION ALL
SELECT 'D' as Parent, 'Male' as ChildGender


select Parent
from tblPerson
group by parent
having count(case when ChildGender = 'Male' then 1 End) > 0
	And count(case when ChildGender = 'Female' then 1 end) > 0