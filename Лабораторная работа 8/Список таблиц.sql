--������� ����� ���� ������, ���������� ������� �������� ������� ������������ ���� ������

select name as ������� from sys.tables -- ��� �������(��� ������, ������������� � �������(��� ���� � object)
where sys.tables.[schema_id] = -- ����� = ��������
(select [principal_id]
from sys.database_principals -- �������, ����������� ��� ���� (�����, ������, ���� � �.�.)
where name = user_name()) --  ��� �������� �����
and sys.tables.[type] = 'U' -- �������� �� ��, ��� ��� �� ��������� �������, � ��������� ����
and object_id not in (select major_id from sys.extended_properties where name = 'microsoft_database_tools_support') -- �� ������� ���������