select distinct CUSTOMER.city

from CUSTOMER
 join EMPLOYEE on EMPLOYEE.employee_id=CUSTOMER.salesperson_id
 join DEPARTMENT on DEPARTMENT.department_id=EMPLOYEE.department_id
 join LOCATION on DEPARTMENT.location_id=LOCATION.location_id

where LOCATION.regional_group='DALLAS'

