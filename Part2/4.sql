select orderid, sum(qty*unitprice) as [total value] 
from Sales.OrderDetails
where qty*unitprice >= 10000
group by orderid
order by [total value] desc 