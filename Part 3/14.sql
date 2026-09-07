--Create table
CREATE TABLE tblFruit
(
Name VARCHAR(20)
,Fruit VARCHAR(25)
)
GO
 
--Insert Data
INSERT INTO tblFruit(Name,Fruit) VALUES
('Neeraj'    ,'MANGO'),
('Neeraj'    ,'MANGO'),
('Neeraj'    ,'MANGO'),
('Neeraj'    ,'APPLE'),
('Neeraj'    ,'ORANGE'),
('Neeraj'    ,'LICHI'),
('Neeraj'    ,'LICHI'),
('Neeraj'    ,'LICHI'),
('Isha'     ,'MANGO'),
('Isha'     ,'MANGO'),
('Isha'     ,'APPLE'),
('Isha'     ,'ORANGE'),
('Isha'     ,'LICHI'),
('Gopal' ,'MANGO'),
('Gopal' ,'MANGO'),
('Gopal' ,'APPLE'),
('Gopal' ,'APPLE'),
('Gopal' ,'APPLE'),
('Gopal' ,'ORANGE'),
('Gopal' ,'LICHI'),
('Mayank'  ,'MANGO'),
('Mayank'  ,'MANGO'),
('Mayank'  ,'APPLE'),
('Mayank'  ,'APPLE'),
('Mayank'  ,'ORANGE'),
('Mayank'  ,'LICHI')
 
--Verify Data
SELECT Name,Fruit FROM tblFruit


-- QUERY  PIVOT 
SELECT 
    Name,
    [Mango] AS MangoCount,
    [APPLE] AS APPLECount,
    [LICHI] AS LICHICount,
    [ORANGE] AS ORANGECount
FROM tblFruit
PIVOT (
    COUNT(Fruit)
    FOR Fruit IN ([Mango], [APPLE], [LICHI], [ORANGE])
) AS PivotTable;



-- GROUP BY 
SELECT 
    Name,
    COUNT(CASE WHEN Fruit = 'Mango' THEN 1 END) AS MangoCount,
    COUNT(CASE WHEN Fruit = 'APPLE' THEN 1 END) AS APPLECount,
    COUNT(CASE WHEN Fruit = 'LICHI' THEN 1 END) AS LICHICount,
    COUNT(CASE WHEN Fruit = 'ORANGE' THEN 1 END) AS ORANGECount
FROM tblFruit
GROUP BY Name;

-- JOIN 
SELECT 
    f.Name,
    COUNT(m.Fruit) AS MangoCount,
    COUNT(a.Fruit) AS APPLECount,
    COUNT(l.Fruit) AS LICHICount,
    COUNT(o.Fruit) AS ORANGECount
FROM (SELECT DISTINCT Name FROM tblFruit) f
LEFT JOIN tblFruit m ON f.Name = m.Name AND m.Fruit = 'Mango'
LEFT JOIN tblFruit a ON f.Name = a.Name AND a.Fruit = 'APPLE'
LEFT JOIN tblFruit l ON f.Name = l.Name AND l.Fruit = 'LICHI'
LEFT JOIN tblFruit o ON f.Name = o.Name AND o.Fruit = 'ORANGE'
GROUP BY f.Name;