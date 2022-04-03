use NewLb
drop index if exists cid_index on Customers
drop index if exists cus_index on Customers
drop index if exists order_index on Orders
drop index if exists oid_index on Orders
drop index if exists city on Customers
drop index if exists city2 on Customers
drop index if exists ord_index on OrderDetails
drop index if exists cind on Customers
drop index if exists pind on Products
drop index if exists Orders_clustered ON Orders
drop index if exists Customer_clustered ON Customers

-- индекс 1
create index city2 -- по умолчанию nonclustered
on Customers(City) -- некластеризованные индексы эффективны в запросах с использованием where
include (CustomerID, ContactName)
-- запрос 1
-- с индексом - время - 0 мс, количество чтений - 5
-- без индекса - время - 2 мс, кол-во чтений - 606
-- запрос 2
-- с индексом - время - 95 мс, чтений - 184
-- без индекса - время 144 мс, чтений - 1212

-- индексы 2-3 
create clustered index Customer_clustered -- кластеризованные индексы оказываются очень эффективными при объдинении таблиц
on Customers (CustomerID)
create clustered index  Orders_clustered 
on Orders (CustomerID) 

-- запрос 3
-- без индексов - время - 104 мс, время цп - 18 мс, чтений - 633
-- c кластеризованными индексами - время - 4 мс, время цп - 0 мс, чтений - 405

-- индекс 4
create index oid_index
on Orders(OrderID) include (ShipName)

-- индекс 5
create index pind on
Products(ProductID) include (ProductName)

-- индекс 6
create index cind on
Customers(CustomerID) include (CompanyName)

-- запрос 4
-- без индексов - время - 3509 мс, чтений - 843
-- c индексами - время - 3108 мс, чтений - 355
-- заметим, что время цп упало в 2.5 - 3 раза

--with (drop_existing=ON) - удаляет существующий индекс и создает новый

/*
-- индекс 2
create clustered index cid_index
on Customers(CustomerID)

-- индекс 3
create clustered index order_index
on Orders(ShippedDate)

-- индекс 4
create index cus_index
on Customers(CustomerID,City,Country)
include (ContactName,CompanyName)
*/