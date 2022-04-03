select top 1 Row_number() over(order by CUSTOMER.customer_id)
from CUSTOMER
inner join sales_order on sales_order.customer_id=Customer.Customer_id
group by CUSTOMER.customer_id
having min(year(sales_order.order_date)) = 1990
Order by CUSTOMER.customer_id desc