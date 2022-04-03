

--������� ������ ������ � ������� ���������� ������ ������ � �����.
--�������� � ������ ������ �� �����, � ������� ���� �� ����� 10 ������.

with a as ( 
	select 
		customer.state,
		sum(SALES_ORDER.total) as totalSum,
		count(*) as OrderCount
	from Customer
	inner join SALES_ORDER on SALES_ORDER.customer_id =CUSTOMER.customer_id
	group by CUSTOMER.state )

	
Select a.state
from a
where a.OrderCount >=10
order by a.totalSum asc
