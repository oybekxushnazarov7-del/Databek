select empid, firstname, lastname
from HR.Employees
where (LEN(lastname) - LEN(replace(lower(lastname), 'e', ''))) >= 2 