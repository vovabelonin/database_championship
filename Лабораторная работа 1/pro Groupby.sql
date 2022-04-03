select 
state,count(*) as q, 
min(credit_limit) as min_cl,
max(credit_limit) as max_cl
from CUSTOMER
group by state 

select *
from CUSTOMER 
