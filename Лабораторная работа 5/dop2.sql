use NewLb
if (OBJECT_ID ('dop2') IS NOT NULL)
  DROP VIEW dop2;
GO
CREATE VIEW dop2 AS 
	select PLAYER.name from player
	where player.NAME in (select PLAYER.name from player group by PLAYER.NAME)

select * from dop2

update dop2 
set name = 'Иван'
where dop2.NAME='victor'



