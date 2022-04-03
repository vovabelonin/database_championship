--выбрать название ограничения целостности (первичные и внешние ключи), 
--имя таблицы, в которой оно находится, 
--признак того, что это за ограничение ('PK' для первичного ключа и 'F' для внешнего) - для всех ограничений целостности, созданных назначенным пользователем базы данных

Declare @userName varchar(100)

--Set @UserName='TUser'
Set @UserName='dbo'


select 
K.name as ConstName,
T.name as tableName,
K.Type as ConstrType

from sys.objects as K 
Inner join sys.objects as T on T.Object_id=K.parent_object_id 
Inner join sys.database_principals as p on OBJECTPROPERTY(T.object_id, 'OwnerID')=P.principal_id --берем констрайнты из таблиц созданных этим юзером, а не констрайнты созданные этим юзером.
--если брать констрайнты созданные этим юзером то надо писать "K.object_ID"
where  
K.type in ('F','PK')
and p.name = @userName


