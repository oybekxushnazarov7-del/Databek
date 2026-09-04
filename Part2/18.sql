SELECT custid, ordermonth, qty,
       (
           SELECT SUM(CO2.qty)
           FROM Sales.CustOrders AS CO2
           WHERE CO2.custid = CO.custid
             AND CO2.ordermonth <= CO.ordermonth
       ) AS runqty
FROM Sales.CustOrders AS CO
order by custid, ordermonth