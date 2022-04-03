select 
state ,
SUM(SALES_ORDER.TOTAL) AS S,
COUNT(*) AS Q

from CUSTOMER
INNER JOIN SALES_ORDER ON SALES_ORDER.customer_id =CUSTOMER.customer_id
where 1=1
group by state
---order by state  
--ORDER BY S

--select *
--from CUSTOMER 
