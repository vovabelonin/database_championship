--������� ����� ���� ������, ���������� ������� �������� ����������� ������������ ���� ������
Declare @userName varchar(100)
Set @UserName='TUser'

select O.name
from sys.objects as O
Inner join sys.database_principals as P on OBJECTPROPERTY(o.object_id, 'OwnerID')=P.principal_id 
where o.type = 'U' --����� ������ ������� (�����������)
and P.name=@UserName


--������� ��� �������, ��� ������� �������, ������� ����, ��������� �� ������ ������� null-��������, 
--�������� ���� ������ ������� �������, ������ ����� ���� ������ - ��� ���� ������, 
--��������� ����������� ������������� ���� ������ � ���� �� ��������
Declare @userName varchar(100)
Set @UserName='TUser'

select o.name as TableName, C.name as ColumnName, C.is_nullable, T.name as TypeName, T.max_length 
from sys.objects as O
inner join sys.columns as C on o.[object_id] = C.[object_id]
inner join sys.types  as T on c.[system_type_id]=t.[system_type_id]
Inner join sys.database_principals as p on OBJECTPROPERTY(o.object_id, 'OwnerID')=P.principal_id 
where  p.name = @userName 
order by 1,2



--������� �������� ����������� ����������� (��������� � ������� �����), 
--��� �������, � ������� ��� ���������, 
--������� ����, ��� ��� �� ����������� ('PK' ��� ���������� ����� � 'F' ��� ��������) - ��� ���� ����������� �����������, ��������� ����������� ������������� ���� ������

Declare @userName varchar(100)
--Set @UserName='TUser'
Set @UserName='dbo'

select 
K.name as ConstName,
T.name as tableName,
K.Type as ConstrType

from sys.objects as K 
Inner join sys.objects as T on T.Object_id=K.parent_object_id 
Inner join sys.database_principals as p on OBJECTPROPERTY(T.object_id, 'OwnerID')=P.principal_id --����� ����������� �� ������ ��������� ���� ������, � �� ����������� ��������� ���� ������.
--���� ����� ����������� ��������� ���� ������ �� ���� ������ "K.object_ID"
where  
K.type in ('F','PK')
and p.name = @userName




--������� �������� ��������(foreign) �����, ��� �������, ���������� ������� ����, 
--��� �������, ���������� ��� ������������ ���� - ��� ���� ������� ������, ��������� ����������� ������������� ���� ������

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
Inner join sys.database_principals as p on OBJECTPROPERTY(T.object_id, 'OwnerID')=P.principal_id --����� ����������� �� ������ ��������� ���� ������, � �� ����������� ��������� ���� ������.
--���� ����� ����������� ��������� ���� ������ �� ���� ������ "K.object_ID"
where  
p.name = @userName  
order by 1,2
--select * from sys.foreign_keys 



--������� �������� �������������, 
--SQL-������, ��������� ��� ������������� -
--��� ���� �������������, ��������� ����������� ������������� ���� ������

Declare @userName varchar(100)
--Set @UserName='TUser'
Set @UserName='dbo'

select 
V.name, 
OBJECT_DEFINITION(OBJECT_ID(V.name,'V')) as definition
from sys.views as v
inner join sys.database_principals as p on OBJECTPROPERTY(v.object_id, 'OwnerID')=P.principal_id
where P.name = @userName  



--������� �������� ��������, 
--��� �������, ��� ������� ��������� ������� 
-- ��� ���� ���������, ��������� ����������� ������������� ���� ������

Declare @userName varchar(100)
--set @userName ='TUser'
set @userName ='dbo'

Select tr.name as TriggerName,
T.name as TableName
from sys.triggers as Tr
Inner join sys.objects as T on T.Object_ID=Tr.parent_id 
Inner join sys.database_principals as p on OBJECTPROPERTY(T.object_id, 'OwnerID')=P.principal_id --����� ����������� �� ������ ��������� ���� ������, � �� ����������� ��������� ���� ������.
--���� ����� ����������� ��������� ���� ������ �� ���� ������ "K.object_ID"
where p.name=@userName 