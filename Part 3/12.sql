--Create table
CREATE TABLE TestMax
(
Year1 INT
,Max1 INT
,Max2 INT
,Max3 INT
)
GO
 
--Insert data
INSERT INTO TestMax 
VALUES
 (2001,10,101,87)
,(2002,103,19,88)
,(2003,21,23,89)
,(2004,27,28,91)
 
--Select data
Select Year1,Max1,Max2,Max3 FROM TestMax




-- QUERY 

select Year1, max(greatest(Max1,Max2,Max3)) as MaxValue 
from TestMax
group by Year1