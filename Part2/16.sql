select custid, companyname
from Sales.Customers as C
where exists (
    select orderdate 
    from Sales.Orders as O
    where year(orderdate) = 2015
      and O.custid = C.custid
)
and not exists (
    select orderdate
    from Sales.Orders as O
    where year(orderdate) = 2016
      and O.custid = C.custid
);