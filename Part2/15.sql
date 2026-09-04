select custid, orderid, orderdate, empid
from sales.Orders as O
where O.orderdate = (
	select max(orderdate)
	from Sales.Orders as O2
	where O2.custid = O.custid
)
order by custid asc