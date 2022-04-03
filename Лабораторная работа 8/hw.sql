USE HOSPITAL

--1)������� ����� ���� ������, ������� ������� <user_name>
SELECT name FROM sys.tables                           
WHERE                                                  
USER_NAME(OBJECTPROPERTY([object_id], 'OwnerId'))='dbo'

select name from sysobjects where xtype = 'U'

Select Table_name as "Table name"
From   Information_schema.Tables
Where  Table_type = 'BASE TABLE' 
       and Table_Name Not In ('dtproperties','sysdiagrams')



 SELECT *
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_NAME NOT LIKE 'sys%'
	AND TABLE_NAME IN (select name from sysobjects where xtype = 'U')

   SELECT TABLE_NAME AS [�������� �������]
   FROM INFORMATION_SCHEMA.TABLES
   WHERE table_type='BASE TABLE'

--2)������� ��� �������, ��� ������� �������, ������� ����, 
--��������� �� ������ ������� null-��������, �������� ���� ������ ������� �������, 
--������ ����� ���� ������ - ��� ���� ������, �������� ������� ����������� ������������ 
--���� ������ � ���� �� ��������
SELECT OBJECT_NAME(sc.object_id) AS [�������], sc.name AS [��� �������], sc.is_nullable [�������� �� NULL-��������], 
TYPE_NAME(sc.user_type_id) AS [��� ������], sc.max_length AS [������ ���� ������ (� ������)]
FROM sys.columns sc, sys.objects so
WHERE USER_NAME(OBJECTPROPERTY(sc.object_id, 'OwnerId')) = 'dbo' AND so.object_id = sc.object_id AND type = 'U' 

--3)������� �������� ����������� ����������� (��������� � ������� �����), ��� �������, � ������� ��� ���������, ������� 
--����, ��� ��� �� ����������� ('PK' ��� ���������� ����� � 'F' ��� ��������) - ��� ���� ����������� �����������, 
--��������� ����������� ������������� ���� ������
SELECT so.name AS [�������� �����������], OBJECT_NAME(so.parent_object_id) AS [�������� �������], 
so.[type] AS [��� �����������] FROM sys.objects so
WHERE (so.type = 'F' OR so.type = 'PK') AND USER_NAME(OBJECTPROPERTY(so.object_id, 'OwnerId')) = 'dbo'

--4)������� �������� �������� �����, ��� �������, ���������� ������� ����, ��� �������, ���������� ��� ������������ 
--���� - ��� ���� ������� ������, ��������� ����������� ������������� ���� ������
SELECT sf.name AS [�������� �����������], OBJECT_NAME(sf.parent_object_id) AS [�������� ������� ������], 
OBJECT_NAME(sf.referenced_object_id) AS [�������� ������� ����]
FROM sys.foreign_keys sf
WHERE USER_NAME(OBJECTPROPERTY(sf.object_id, 'OwnerId')) = 'dbo'

--5)������� �������� �������������, SQL-������, ��������� ��� ������������� - ��� ���� �������������, 
--���������� ������� �������� ����������� ������������ ���� ������
SELECT [name], [definition] FROM sys.views sv
INNER JOIN sys.sql_modules sm ON sv.object_id = sm.object_id
WHERE USER_NAME(OBJECTPROPERTY(sm.object_id, 'OwnerId')) = 'dbo'

--6)������� �������� ��������, ��� �������, ��� ������� ��������� ������� - ��� ���� ���������, ���������� �������
--�������� ����������� ������������ ���� ������
SELECT name, OBJECT_NAME(parent_object_id) AS [Table] from sys.objects
WHERE type = 'TR' AND USER_NAME(OBJECTPROPERTY(object_id, 'OwnerId')) = 'dbo'