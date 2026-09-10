SELECT orderid, SUM(qty * unitprice) AS [total value]
FROM Sales.OrderDetails
GROUP BY orderid
HAVING SUM(qty * unitprice) > 10000
ORDER BY [total value] DESC;