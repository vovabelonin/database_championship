-- акой покупатель за все врем€ закупил товара, в названии которого имеетс€ слово'DUNK' на наибольшую сумму.


---With a as (
select top 1 with ties sum(ITEM.total) as S,CUSTOMER.name
from CUSTOMER
inner join SALES_ORDER on SALES_ORDER.customer_id=CUSTOMER.customer_id
inner join ITEM on SALES_ORDER.order_id=ITEM.order_id
inner join PRODUCT on PRODUCT.product_id=ITEM.product_id
where PRODUCT.description like '%DUNK%' 
group by CUSTOMER.name
order by S desc
--)
--select top 1 name from a
--order by S desc