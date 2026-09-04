select orderid, orderdate, custid, empid
from Sales.Orders 
where orderdate >= '2015-06-01' and orderdate <= '2015-06-30'
-- select query