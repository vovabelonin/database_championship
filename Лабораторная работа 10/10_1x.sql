USE NewLb
--Elapsed time - время затраченное вообще на выполнение комманды.
--CPU - это часть от этого времени, которую процесс, выполняющий эту комманду, потратил в состоянии выполнения, а не ожидания.
GO

SELECT * INTO Customers_without_index FROM Customers
SELECT * INTO Customers_with_clustered FROM Customers
GO

CREATE NONCLUSTERED INDEX Customer_nonclustered ON Customers(city, CustomerID) INCLUDE (contactname, companyname, phone, fax);
CREATE CLUSTERED INDEX Customer_clustered ON Customers_with_clustered(city, CustomerID);
GO
--создаем индекс на уникальное и короткое значение customerid
--столбец city первый в индексе так как его значение используется в where
SET STATISTICS IO ON
SET STATISTICS TIME ON

GO

--без индекса
SELECT contactname, companyname, phone, fax
FROM Customers_without_index
WHERE (City BETWEEN 'Munchen' AND 'Munchen')
AND (CustomerID BETWEEN 'A' AND 'Q')

--с некластеризированным индексом
SELECT contactname, companyname, phone, fax
FROM Customers
WHERE (City BETWEEN 'Munchen' AND 'Munchen')
AND (CustomerID BETWEEN 'A' AND 'Q')

--с кластеризированным индексом
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