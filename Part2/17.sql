select C.custid, C.companyname
from Sales.Customers as C
where exists (
	select O.orderid 
	from sales.Orders as O
	where O.custid = C.custid
		and exists (
			select D.orderid 
			from Sales.OrderDetails as D
			where D.orderid = O.orderid
			and D.productid = 12 
		)
);