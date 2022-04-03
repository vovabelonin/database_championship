--выбрать название внешнего(foreign) ключа, имя таблицы, содержащей внешний ключ, 
--имя таблицы, содержащей его родительский ключ - для всех внешних ключей, созданных назначенным пользователем базы данных

Declare @userName varchar(100)

--Set @UserName='TUser'
Set @UserName='dbo'


select 
K.name as FK_name,
T.name as MaintableName,
RT.name as RefTableName

from sys.foreign_keys as K
inner join sys.objects as T on T.object_ID=K.Parent_object_id
Inner join sys.objects as RT on RT.Object_id=K.referenced_object_id 
Inner join sys.database_principals as p on OBJECTPROPERTY(T.object_id, 'OwnerID')=P.principal_id --берем констрайнты из таблиц созданных этим юзером, а не констрайнты созданные этим юзером.
--если брать констрайнты созданные этим юзером то надо писать "K.object_ID"
where  
p.name = @userName  
order by 1,2
--select * from sys.foreign_keys 
