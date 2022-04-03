USE NewLb

GO

SELECT * INTO Customers_without_index FROM Customers
SELECT * INTO Orders_without_index FROM Orders
SELECT * INTO Customers_with_nonclustered FROM Customers
SELECT * INTO Orders_with_nonclustered FROM Orders

GO

CREATE CLUSTERED INDEX Customer_clustered ON Customers (CustomerID, city)
CREATE CLUSTERED INDEX Orders_clustered ON Orders (CustomerID, shipcity, orderdate)

CREATE NONCLUSTERED INDEX Customer_nonclustered ON Customers_with_nonclustered(CustomerID, city) INCLUDE (companyname);
CREATE NONCLUSTERED INDEX Orders_nonclustered ON Orders_with_nonclustered(CustomerID, shipcity, orderdate) INCLUDE (freight);

GO

SET STATISTICS IO ON
SET STATISTICS TIME ON

GO

--без индекса
SELECT companyname, orderdate, freight
FROM Customers_without_index
	JOIN Orders_without_index
	ON Orders_without_index.customerid = Customers_without_index.customerid
WHERE Customers_without_index.city = 'Helsinki'
	AND Orders_without_index.ShipCity = 'Helsinki'
	AND Orders_without_index.orderdate BETWEEN '19970101' AND '19980101'

--с некластеризированным индексом
SELECT companyname, orderdate, freight
FROM Customers_with_nonclustered
	JOIN Orders_with_nonclustered
	ON Orders_with_nonclustered.customerid = Customers_with_nonclustered.customerid
WHERE Customers_with_nonclustered.city = 'Helsinki'
	AND Orders_with_nonclustered.ShipCity = 'Helsinki'
	AND Orders_with_nonclustered.orderdate BETWEEN '19970101' AND '19980101'

--с кластеризированным индексом
SELECT companyname, orderdate, freight
FROM Customers
	JOIN Orders
	ON Orders.customerid = Customers.customerid
WHERE Customers.city = 'Helsinki'
	AND Orders.ShipCity = 'Helsinki'
	AND Orders.orderdate BETWEEN '19970101' AND '19980101'
--

SET STATISTICS IO OFF
SET STATISTICS TIME OFF

DROP INDEX Customer_clustered ON Customers
DROP INDEX Orders_clustered ON Orders
DROP INDEX Customer_nonclustered ON Customers_with_nonclustered
DROP INDEX Orders_nonclustered ON Orders_with_nonclustered

DROP TABLE Customers_without_index
DROP TABLE Orders_without_index
DROP TABLE Customers_with_nonclustered
DROP TABLE Orders_with_nonclustered