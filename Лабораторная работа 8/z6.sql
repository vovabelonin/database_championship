--������� �������� ��������, 
--��� �������, ��� ������� ��������� ������� 
-- ��� ���� ���������, ��������� ����������� ������������� ���� ������

Declare @userName varchar(100)

set @userName ='TUser'
--set @userName ='dbo'

Select tr.name as TriggerName,
T.name as TableName
from sys.triggers as Tr
Inner join sys.objects as T on T.Object_ID=Tr.parent_id 
Inner join sys.database_principals as p on OBJECTPROPERTY(T.object_id, 'OwnerID')=P.principal_id --����� ����������� �� ������ ��������� ���� ������, � �� ����������� ��������� ���� ������.
--���� ����� ����������� ��������� ���� ������ �� ���� ������ "K.object_ID"
where p.name=@userName 