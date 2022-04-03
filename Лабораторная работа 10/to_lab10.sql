use NewLb
set statistics io on -- позволяет отображать сведения об активности диска
set statistics time on -- отображает время в мс, необходимое для синтаксического анализа, компиляции и выполнения инструкции

set showplan_xml on -- возвращает сведения о плане выполнения инструкций
set showplan_xml off

-- запрос 1
select ContactName
from Customers
where City = 'Berlin'

-- запрос 2
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

-- запрос 3
select companyname, shippeddate, freight
from Customers
join Orders on Orders.customerid = Customers.customerid
where Customers.city = 'Munchen'
	and Orders.shippeddate between '19970101' and '19971231'
	and Orders.freight > 200

-- запрос 4
select CompanyName,ProductName,ShipName
from Customers,OrderDetails,Orders,Products
where (Customers.CustomerID=Orders.CustomerID)
	and (Orders.OrderID=OrderDetails.OrderID)
	and (Products.ProductID=OrderDetails.ProductID)
	and (Products.UnitPrice>10)

/*
-- запрос 3
SELECT ShipName 
FROM Orders,Customers 
WHERE (ShippedDate>'01/01/1990') AND (ShippedDate<'01/01/1999')
and (Orders.CustomerID=Customers.CustomerID)
*/