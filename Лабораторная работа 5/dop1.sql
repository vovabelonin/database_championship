if (OBJECT_ID ('AZ') IS NOT NULL)
  DROP VIEW AZ;
GO
CREATE VIEW AZ AS --97a--122z
	with T (ID) as (
	select 65 as ID --A
​union all
	select ID + 1
 ​from T
	​where ID + 1 <=90--Z​
​​)
select char(ID) as Letter from T​
go
select*from ​AZ