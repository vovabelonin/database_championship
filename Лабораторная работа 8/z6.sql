--выбрать название триггера, 
--имя таблицы, для которой определен триггер 
-- для всех триггеров, созданных назначенным пользователем базы данных

Declare @userName varchar(100)

set @userName ='TUser'
--set @userName ='dbo'

Select tr.name as TriggerName,
T.name as TableName
from sys.triggers as Tr
Inner join sys.objects as T on T.Object_ID=Tr.parent_id 
Inner join sys.database_principals as p on OBJECTPROPERTY(T.object_id, 'OwnerID')=P.principal_id --берем констрайнты из таблиц созданных этим юзером, а не констрайнты созданные этим юзером.
--если брать констрайнты созданные этим юзером то надо писать "K.object_ID"
where p.name=@userName 