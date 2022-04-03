select dp.name,isnull(dp1.name,'0')
from sys.database_principals as dp
join sys.database_role_members as drm on drm.role_principal_id = dp.principal_id
join sys.database_principals as dp1 on dp1.principal_id = drm.member_principal_id
where dp.type = 'R' and dp1.name = 'TUser'
union all
--тоже самое с sys.server_principals и sys.server_role_members
select dp.name,isnull(dp1.name,'0')
from sys.server_principals as dp
join sys.server_role_members as drm on drm.role_principal_id = dp.principal_id
join sys.server_principals as dp1 on dp1.principal_id = drm.member_principal_id
where dp.type = 'R' and dp1.name = 'TUser'

--Вывести все роли,и пользователей которые им принадлежат


select * from sys.database_principals