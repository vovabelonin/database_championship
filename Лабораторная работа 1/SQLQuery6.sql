select 
--order_id ,
--order_date ,
customer_id,
--ship_date ,
sum(total) as s,
count(*) as q
from SALES_ORDER
group by customer_id