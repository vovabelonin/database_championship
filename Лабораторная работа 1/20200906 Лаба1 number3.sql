--����� 3
--���������� ���������� ���������� �����������, ������������� � 1990 ����.

select
CUSTOMER.customer_id,
min(year(sales_order.order_date)) as y
from CUSTOMER
inner join sales_order on sales_order.customer_id=Customer.Customer_id
group by CUSTOMER.customer_id
having min(year(sales_order.order_date)) = 1990
order by y desc	
