--выбрать имя таблицы, имя столбца таблицы, признак того, допускает ли данный столбец null-значения, 
--название типа данных столбца таблицы, размер этого типа данных - для всех таблиц, 
--созданных назначенным пользователем базы данных и всех их столбцов

Declare @userName varchar(100)

Set @UserName='TUser'

select o.name as TableName, C.name as ColumnName, C.is_nullable, T.name as TypeName, T.max_length 
from sys.objects as O
inner join sys.columns as C on o.[object_id] = C.[object_id]
inner join sys.types  as T on c.[system_type_id]=t.[system_type_id]
Inner join sys.database_principals as p on OBJECTPROPERTY(o.object_id, 'OwnerID')=P.principal_id 
where  p.name = @userName 
order by 1,2