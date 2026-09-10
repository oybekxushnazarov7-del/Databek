select E.empid, E.firstname, E.lastname, N.n
from Nums n
cross join HR.Employees E
where N.n <= 5