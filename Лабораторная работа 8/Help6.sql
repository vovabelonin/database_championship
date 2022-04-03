select * from sysobjects
select * from syscolumns
select * from systypes
select * from sysreferences
select * from syscomments
select * from sysusers
select * from sys.database_principals
select * FROM SYS.VIEWS
Declare @userName varchar(100)
--Set @UserName='TUser'
Set @UserName='dbo'
select 
V.name, 
OBJECT_DEFINITION(OBJECT_ID(V.name,'V')) as definition
from sys.views as v
inner join sys.database_principals as p on OBJECTPROPERTY(v.object_id, 'OwnerID')=P.principal_id
where P.name = @userName  
