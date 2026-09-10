select C.custid, C.companyname
from Sales.Customers C 
left join Sales.Orders O on C.custid = O.custid 
where orderid is NULL 