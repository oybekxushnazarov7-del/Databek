select C.custid, C.companyname, O.orderid, O.orderdate
from Sales.Orders O
right join Sales.Customers C
	on O.custid = C.custid 
	and O.orderdate = '2016-02-12'