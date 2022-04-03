with A as(
select city,
sum(total) as S,
count(8) as Q
from CUSTOMER
inner join SALES_ORDER on CUSTOMER.customer_id=SALES_ORDER.customer_id
group by city
)
select City,S,Q from A
where Q<=3
order by S