--выбрать имена всех таблиц, владельцем которой является текущий пользователь базы данных

select name as Таблицы from sys.tables -- все таблицы(без ключей, представлений и другого(что есть в object)
where sys.tables.[schema_id] = -- схема = владелец
(select [principal_id]
from sys.database_principals -- таблица, сохраняющая все лица (юзеры, группы, роли и т.д.)
where name = user_name()) --  имя текущего юзера
and sys.tables.[type] = 'U' -- проверка на то, что это не системная таблица, а созданная нами
and object_id not in (select major_id from sys.extended_properties where name = 'microsoft_database_tools_support') -- не выводит диаграмму