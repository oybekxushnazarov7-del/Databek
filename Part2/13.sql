GO
USE TSQLV4
GO

select empid, firstname as Firstnmae, lastname
from HR.Employees as E
where not exists (
	select O.orderdate
	from Sales.Orders as O
	where O.empid = E.empid and orderdate >= '2016-05-01'
);