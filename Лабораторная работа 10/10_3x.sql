USE NewLb

GO

SELECT * INTO Customers_without_index FROM Customers
SELECT * INTO Orders_without_index FROM Orders
SELECT * INTO OrderDetails_without_index FROM OrderDetails
SELECT * INTO Products_without_index FROM Products

SELECT * INTO Customers_nonclustered FROM Customers
SELECT * INTO Orders_nonclustered FROM Orders
SELECT * INTO OrderDetails_nonclustered FROM OrderDetails
SELECT * INTO Products_nonclustered FROM Products

CREATE CLUSTERED INDEX Clast_Customers ON Customers(CustomerID)
CREATE CLUSTERED INDEX Clast_Orders ON Orders(CustomerID,OrderID)
CREATE CLUSTERED INDEX Clast_OrderDetails ON OrderDetails (OrderID,ProductID)
CREATE CLUSTERED INDEX Clast_Products ON Products (ProductID)

CREATE NONCLUSTERED INDEX Non_Customers ON Customers_nonclustered(CustomerID, City)
CREATE NONCLUSTERED INDEX Non_Orders ON Orders_nonclustered(CustomerID,OrderID,EmployeeID)
CREATE NONCLUSTERED INDEX Non_OrderDetails ON OrderDetails_nonclustered (OrderID,ProductID,Discount)
CREATE NONCLUSTERED INDEX Non_Products ON Products_nonclustered (ProductID, UnitsInStock)

SET STATISTICS IO ON
SET STATISTICS TIME ON

--без индекса

SELECT Customers_without_index.CustomerID, EmployeeID, City, Products_without_index.ProductID,
		Products_without_index.UnitsInStock, OrderDetails_without_index.Discount
FROM Customers_without_index
	JOIN Orders_without_index
		ON Customers_without_index.CustomerID = Orders_without_index.CustomerID
	JOIN OrderDetails_without_index
		ON Orders_without_index.OrderID = OrderDetails_without_index.OrderID
	JOIN Products_without_index
		ON OrderDetails_without_index.ProductID = Products_without_index.ProductID
WHERE EmployeeID = 7 AND
	City = 'Nantes' AND
	OrderDetails_without_index.Discount = 0 AND
	Products_without_index.UnitsInStock < 25

--с некластеризированным индексом

SELECT Customers_nonclustered.CustomerID, EmployeeID, City, Products_nonclustered.ProductID,
		Products_nonclustered.UnitsInStock, OrderDetails_nonclustered.Discount
FROM Customers_nonclustered
	JOIN Orders_nonclustered
		ON Customers_nonclustered.CustomerID = Orders_nonclustered.CustomerID
	JOIN OrderDetails_nonclustered
		ON Orders_nonclustered.OrderID = OrderDetails_nonclustered.OrderID
	JOIN Products_nonclustered
		ON OrderDetails_nonclustered.ProductID = Products_nonclustered.ProductID
WHERE EmployeeID = 7 AND
	City = 'Nantes' AND
	OrderDetails_nonclustered.Discount = 0 AND
	Products_nonclustered.UnitsInStock < 25
--с кластеризированным индексом

SELECT Customers.CustomerID, EmployeeID, City, Products.ProductID, Products.UnitsInStock, OrderDetails.Discount
FROM Customers 
	JOIN Orders
		ON Customers.CustomerID = Orders.CustomerID
	JOIN OrderDetails
		ON Orders.OrderID = OrderDetails.OrderID
	JOIN Products
		ON OrderDetails.ProductID = Products.ProductID
WHERE EmployeeID = 7 AND
	City = 'Nantes' AND
	OrderDetails.Discount = 0 AND
	Products.UnitsInStock < 25


SET STATISTICS IO OFF
SET STATISTICS TIME OFF

DROP INDEX Clast_Customers ON Customers
DROP INDEX Clast_Orders ON Orders
DROP INDEX Clast_Products ON Products
DROP INDEX Clast_OrderDetails ON OrderDetails

DROP INDEX Non_Customers ON Customers_nonclustered
DROP INDEX Non_Orders ON Orders_nonclustered
DROP INDEX Non_Products ON Products_nonclustered
DROP INDEX Non_OrderDetails ON OrderDetails_nonclustered

DROP TABLE Customers_without_index
DROP TABLE Orders_without_index
DROP TABLE OrderDetails_without_index
DROP TABLE Products_without_index

DROP TABLE Customers_nonclustered
DROP TABLE Orders_nonclustered
DROP TABLE OrderDetails_nonclustered
DROP TABLE Products_nonclustered