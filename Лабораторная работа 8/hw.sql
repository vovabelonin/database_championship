USE HOSPITAL

--1)выбрать имена всех таблиц, влдалец которых <user_name>
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

   SELECT TABLE_NAME AS [Название таблицы]
   FROM INFORMATION_SCHEMA.TABLES
   WHERE table_type='BASE TABLE'

--2)выбрать имя таблицы, имя столбца таблицы, признак того, 
--допускает ли данный столбец null-значения, название типа данных столбца таблицы, 
--размер этого типа данных - для всех таблиц, которыми владеет назначенный пользователь 
--базы данных и всех их столбцов
SELECT OBJECT_NAME(sc.object_id) AS [Таблица], sc.name AS [Имя столбца], sc.is_nullable [Возможно ли NULL-значение], 
TYPE_NAME(sc.user_type_id) AS [Тип данных], sc.max_length AS [Размер типа данных (в байтах)]
FROM sys.columns sc, sys.objects so
WHERE USER_NAME(OBJECTPROPERTY(sc.object_id, 'OwnerId')) = 'dbo' AND so.object_id = sc.object_id AND type = 'U' 

--3)Выбрать название ограничения целостности (первичные и внешние ключи), имя таблицы, в которой оно находится, признак 
--того, что это за ограничение ('PK' для первичного ключа и 'F' для внешнего) - для всех ограничений целостности, 
--созданных назначенным пользователем базы данных
SELECT so.name AS [Название ограничения], OBJECT_NAME(so.parent_object_id) AS [Название таблциы], 
so.[type] AS [Тип ограничения] FROM sys.objects so
WHERE (so.type = 'F' OR so.type = 'PK') AND USER_NAME(OBJECTPROPERTY(so.object_id, 'OwnerId')) = 'dbo'

--4)выбрать название внешнего ключа, имя таблицы, содержащей внешний ключ, имя таблицы, содержащей его родительский 
--ключ - для всех внешних ключей, созданных назначенным пользователем базы данных
SELECT sf.name AS [Название ограничения], OBJECT_NAME(sf.parent_object_id) AS [Название таблицы откуда], 
OBJECT_NAME(sf.referenced_object_id) AS [Название таблицы куда]
FROM sys.foreign_keys sf
WHERE USER_NAME(OBJECTPROPERTY(sf.object_id, 'OwnerId')) = 'dbo'

--5)выбрать название представления, SQL-запрос, создающий это представление - для всех представлений, 
--владельцем которых является назначенный пользователь базы данных
SELECT [name], [definition] FROM sys.views sv
INNER JOIN sys.sql_modules sm ON sv.object_id = sm.object_id
WHERE USER_NAME(OBJECTPROPERTY(sm.object_id, 'OwnerId')) = 'dbo'

--6)выбрать название триггера, имя таблицы, для которой определен триггер - для всех триггеров, владельцем которых
--является назначенный пользователь базы данных
SELECT name, OBJECT_NAME(parent_object_id) AS [Table] from sys.objects
WHERE type = 'TR' AND USER_NAME(OBJECTPROPERTY(object_id, 'OwnerId')) = 'dbo'