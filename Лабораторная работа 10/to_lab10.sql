use NewLb
set statistics io on -- ��������� ���������� �������� �� ���������� �����
set statistics time on -- ���������� ����� � ��, ����������� ��� ��������������� �������, ���������� � ���������� ����������

set showplan_xml on -- ���������� �������� � ����� ���������� ����������
set showplan_xml off

-- ������ 1
select ContactName
from Customers
where City = 'Berlin'

-- ������ 2
select ContactName
from Customers
where 
City =
(select City
from (select City,count(*) as amount
	from Customers
	group by City) as tmp
where amount=(select max(amount)
	from (select City,count(*) as amount
	from Customers
	group by City) as tmp1)
)

-- ������ 3
select companyname, shippeddate, freight
from Customers
join Orders on Orders.customerid = Customers.customerid
where Customers.city = 'Munchen'
	and Orders.shippeddate between '19970101' and '19971231'
	and Orders.freight > 200

-- ������ 4
select CompanyName,ProductName,ShipName
from Customers,OrderDetails,Orders,Products
where (Customers.CustomerID=Orders.CustomerID)
	and (Orders.OrderID=OrderDetails.OrderID)
	and (Products.ProductID=OrderDetails.ProductID)
	and (Products.UnitPrice>10)

/*
-- ������ 3
SELECT ShipName 
FROM Orders,Customers 
WHERE (ShippedDate>'01/01/1990') AND (ShippedDate<'01/01/1999')
and (Orders.CustomerID=Customers.CustomerID)
*/