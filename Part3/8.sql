SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
  LEFT OUTER JOIN Sales.Orders AS O
    ON O.custid = C.custid
WHERE O.orderdate = '20160212'
   OR O.orderid IS NULL;

-- shartida all customers deyilgan bu query da esa faqat
-- orderdate = '20160212' yoki orderid null ni olyapti 