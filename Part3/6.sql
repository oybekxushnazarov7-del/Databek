select C.custid, C.companyname, O.orderid, O.orderdate
from Sales.Orders O
left join Sales.Customers C on O.custid = C.custid 
where orderdate = '2016-02-12'