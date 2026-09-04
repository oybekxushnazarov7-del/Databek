select orderid, orderdate, custid, empid
from Sales.Orders
where custid in 
(
	select Top (1) with ties custid
	from Sales.Orders
	Group by custid 
	order by count(*) desc
)
