SELECT empid, lastname
FROM HR.Employees
WHERE LEFT(lastname, 1) COLLATE Latin1_General_CS_AS LIKE '[a-z]'
  AND LEFT(lastname, 1) COLLATE Latin1_General_CS_AS <> UPPER(LEFT(lastname, 1));


SELECT empid, lastname
FROM HR.Employees
WHERE ASCII(LEFT(lastname, 1)) BETWEEN 97 AND 122;