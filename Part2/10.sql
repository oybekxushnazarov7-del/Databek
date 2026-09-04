select custid, region
from Sales.Customers
Order by
	case when region is null then 87 else 85 End,
	region asc