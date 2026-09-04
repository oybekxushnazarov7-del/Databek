select orderid, orderdate, custid, empid
from Sales.Orders
where orderdate = EOMONTH(orderdate)