--ЗАДАЧА 4
--Какой покупатель за все время закупил товара, в названии которого имеется слово'DUNK' на наибольшую сумму.


with a as (
select
CUSTOMER.name,
CUSTOMER.customer_id,
sum(item.total) as SumTotal
from CUSTOMER 
inner join SALES_ORDER on SALES_ORDER.customer_id =CUSTOMER.customer_id 
inner join item on ITEM.order_id =SALES_ORDER.order_id 
inner join product on PRODUCT.product_id =item.product_id 
where PRODUCT.description like '%DUNK%'
group by CUSTOMER.customer_id,CUSTOMER.name  

)

select top 1 name,customer_id 
from a
order by SumTotal desc
