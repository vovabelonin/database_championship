--������� ����� ���� ������, ���������� ������� �������� ����������� ������������ ���� ������
Declare @userName varchar(100)

Set @UserName='TUser'

select user_id(),OBJECTPROPERTY(o.object_id, 'OwnerID'),*--P.name,*
from sys.objects as O
Inner join sys.database_principals as P on OBJECTPROPERTY(o.object_id, 'OwnerID')=P.principal_id 
where o.type = 'U' --����� ������ ������� (�����������)
and P.name=@UserName





