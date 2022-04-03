select top 1 
Row_number() over(order by customer_id)--,
--customer_id,
--min(year(order_date))
from SALES_ORDER
group by customer_id
having min(year(order_date)) = 1990
Order by customer_id desc