SELECT Customers.custid, Customers.companyname, Orders.orderid, Orders.orderdate
FROM Sales.Customers AS C
  INNER JOIN Sales.Orders AS O
    ON Customers.custid = Orders.custid;

-- in select Alias should C.someting instead of Customers and for Orders 
-- table also. AND INNER Join and ON should locate on the same row for beauty


SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
INNER JOIN Sales.Orders AS O
ON C.custid = O.custid;