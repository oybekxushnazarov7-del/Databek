SELECT custid, orderdate, orderid,
  ROW_NUMBER() OVER (PARTITION BY custid
                      ORDER BY orderdate, orderid) AS rownum
FROM Sales.Orders
ORDER BY custid, rownum;