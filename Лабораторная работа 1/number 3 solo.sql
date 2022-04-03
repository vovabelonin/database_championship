--Определить количество количество покупателей, приобретенных в 1990 году.

with A as (
select min(year(order_date)) as Y,SALES_ORDER.customer_id
from CUSTOMER
inner join SALES_ORDER on SALES_ORDER.customer_id=CUSTOMER.customer_id
group by SALES_ORDER.customer_id
)
select COUNT(*) as Q from A 
where y=1990