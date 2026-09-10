select C.custid, C.companyname, O.orderid, O.orderdate
from Sales.Customers C 
left join Sales.Orders O on C.custid = O.custid