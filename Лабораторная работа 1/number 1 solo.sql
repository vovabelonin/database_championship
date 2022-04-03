--Выбрать названия тех городов, покупатели из которых обслуживаются отделами, расположенными в г.Даллас (DALLAS).

select distinct CUSTOMER.city 
from CUSTOMER
inner join EMPLOYEE on EMPLOYEE.employee_id=CUSTOMER.salesperson_id
inner join DEPARTMENT on DEPARTMENT.department_id=EMPLOYEE.department_id
inner join LOCATION on LOCATION.location_id=DEPARTMENT.location_id
where LOCATION.regional_group='DALLAS'

