USE NewLb
--Elapsed time - ����� ����������� ������ �� ���������� ��������.
--CPU - ��� ����� �� ����� �������, ������� �������, ����������� ��� ��������, �������� � ��������� ����������, � �� ��������.
GO

SELECT * INTO Customers_without_index FROM Customers
SELECT * INTO Customers_with_clustered FROM Customers
GO

CREATE NONCLUSTERED INDEX Customer_nonclustered ON Customers(city, CustomerID) INCLUDE (contactname, companyname, phone, fax);
CREATE CLUSTERED INDEX Customer_clustered ON Customers_with_clustered(city, CustomerID);
GO
--������� ������ �� ���������� � �������� �������� customerid
--������� city ������ � ������� ��� ��� ��� �������� ������������ � where
SET STATISTICS IO ON
SET STATISTICS TIME ON

GO

--��� �������
SELECT contactname, companyname, phone, fax
FROM Customers_without_index
WHERE (City BETWEEN 'Munchen' AND 'Munchen')
AND (CustomerID BETWEEN 'A' AND 'Q')

--� �������������������� ��������
SELECT contactname, companyname, phone, fax
FROM Customers
WHERE (City BETWEEN 'Munchen' AND 'Munchen')
AND (CustomerID BETWEEN 'A' AND 'Q')

--� ������������������ ��������
SELECT contactname, companyname, phone, fax
FROM Customers_with_clustered
WHERE (City BETWEEN 'Munchen' AND 'Munchen')
AND (CustomerID BETWEEN 'A' AND 'Q')
--
SET STATISTICS IO OFF
SET STATISTICS TIME OFF

DROP INDEX Customer_clustered ON Customers_with_clustered
DROP INDEX Customer_nonclustered ON Customers

DROP TABLE Customers_without_index
DROP TABLE Customers_with_clustered