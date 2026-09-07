SELECT
    C.custid,
    COUNT(DISTINCT O.orderid) AS numorders,
    SUM(OD.qty) AS totalqty
FROM Sales.Customers C
INNER JOIN Sales.Orders O
    ON C.custid = O.custid
INNER JOIN Sales.OrderDetails OD
    ON O.orderid = OD.orderid
WHERE C.country = 'USA'
GROUP BY
    C.custid