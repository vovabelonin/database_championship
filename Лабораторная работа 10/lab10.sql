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

-- ������ 1
create index city2 -- �� ��������� nonclustered
on Customers(City) -- ������������������ ������� ���������� � �������� � �������������� where
include (CustomerID, ContactName)
-- ������ 1
-- � �������� - ����� - 0 ��, ���������� ������ - 5
-- ��� ������� - ����� - 2 ��, ���-�� ������ - 606
-- ������ 2
-- � �������� - ����� - 95 ��, ������ - 184
-- ��� ������� - ����� 144 ��, ������ - 1212

-- ������� 2-3 
create clustered index Customer_clustered -- ���������������� ������� ����������� ����� ������������ ��� ���������� ������
on Customers (CustomerID)
create clustered index  Orders_clustered 
on Orders (CustomerID) 

-- ������ 3
-- ��� �������� - ����� - 104 ��, ����� �� - 18 ��, ������ - 633
-- c ����������������� ��������� - ����� - 4 ��, ����� �� - 0 ��, ������ - 405

-- ������ 4
create index oid_index
on Orders(OrderID) include (ShipName)

-- ������ 5
create index pind on
Products(ProductID) include (ProductName)

-- ������ 6
create index cind on
Customers(CustomerID) include (CompanyName)

-- ������ 4
-- ��� �������� - ����� - 3509 ��, ������ - 843
-- c ��������� - ����� - 3108 ��, ������ - 355
-- �������, ��� ����� �� ����� � 2.5 - 3 ����

--with (drop_existing=ON) - ������� ������������ ������ � ������� �����

/*
-- ������ 2
create clustered index cid_index
on Customers(CustomerID)

-- ������ 3
create clustered index order_index
on Orders(ShippedDate)

-- ������ 4
create index cus_index
on Customers(CustomerID,City,Country)
include (ContactName,CompanyName)
*/