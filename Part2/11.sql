select orderid, orderdate, custid, empid
from Sales.Orders
where orderdate = (select max(orderdate) from Sales.Orders)