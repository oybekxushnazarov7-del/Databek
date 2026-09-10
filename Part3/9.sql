select C.custid,
		C.companyname, 
		case
			when exists (
				select 1 
				from Sales.Orders O
				where O.custid = C.custid
					and O.orderdate = '20160212'
			) then 'Yes'
			else 'No'
		End as HasOrderOn20160212
from Sales.Customers C