select distinct country 
from Sales.Customers as C
where not exists (
	select country
	from HR.Employees as E
	where E.country = C.country
);