CREATE TABLE [Movie]
(
 
[MName] [varchar] (10) NULL,
[AName] [varchar] (10) NULL,
[Roles] [varchar] (10) NULL
)
 
GO
 
--Insert data in the table
 
INSERT INTO Movie(MName,AName,Roles)
SELECT 'A','Tom','Actor'
UNION ALL
SELECT 'A','Bob','Villan'
UNION ALL
SELECT 'B','Tom','Actor'
UNION ALL
SELECT 'B','Bob','Actor'
UNION ALL
SELECT 'D','Tom','Actor'
UNION ALL
SELECT 'E','Bob','Actor'
 
--Check your data
SELECT MName , AName , Roles FROM Movie


-- query 

SELECT M1.MName, M1.AName, M1.Roles
FROM Movie M1
INNER JOIN Movie M2
    ON M1.MName = M2.MName
WHERE M1.AName = 'Tom'
  AND M2.AName = 'Bob'
  AND M1.Roles = 'Actor'
  AND M2.Roles = 'Actor'

UNION ALL

SELECT M2.MName, M2.AName, M2.Roles
FROM Movie M1
INNER JOIN Movie M2
    ON M1.MName = M2.MName
WHERE M1.AName = 'Tom'
  AND M2.AName = 'Bob'
  AND M1.Roles = 'Actor'
  AND M2.Roles = 'Actor';