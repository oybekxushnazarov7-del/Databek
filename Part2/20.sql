SELECT
    O1.custid,
    O1.orderid,
    O1.orderdate,
    DATEDIFF(
        day,
        (
            SELECT MAX(O2.orderdate)
            FROM Sales.Orders AS O2
            WHERE O2.custid = O1.custid
              AND (
                  O2.orderdate < O1.orderdate
                  OR (
                      O2.orderdate = O1.orderdate
                      AND O2.orderid < O1.orderid
                  )
              )
        ),
        O1.orderdate
    ) AS diff
FROM Sales.Orders AS O1
order by custid