select 
	E.empid, 
	DATEADD(day, N.n - 1, '20160612') as dt
from HR.Employees E
cross join Nums N
where N.n <= 5;