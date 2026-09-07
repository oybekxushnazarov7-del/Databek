--Create table
CREATE TABLE [dbo].[Person]
(
[EmpID] [int] NULL,
[EmpName] [varchar](50) NULL,
[EmpSalary] [bigint] NULL,
[MgrID] [int] NULL
)
GO
 
--Insert Data
INSERT INTO [Person](EmpID,EmpName,EmpSalary,MgrID)
VALUES
(1,    'Pawan',      80000, 4),
(2,    'Dheeraj',    70000, 4),
(3,    'Isha',       100000,       4),
(4,    'Joteep',     90000, NULL),
(5,    'Suchita',    110000,       4)
 
--Verify Data
SELECT * FROM [dbo].[Person]



-- QUERY 

select P1.EmpID, P1.EmpName, P1.EmpSalary, P1.MgrID
from Person P1
inner join Person P2
on P1.MgrID = P2.EmpID
where P1.EmpSalary > P2.EmpSalary