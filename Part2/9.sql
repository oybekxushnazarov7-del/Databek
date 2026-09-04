select empid, firstname, lastname, titleofcourtesy,
  case titleofcourtesy
	when 'Ms.' Then 'Female'
	When 'Mrs.' Then 'Female'
	When 'Mr.' Then 'Male'
	Else 'Unknown'
  End as gender
from HR.Employees