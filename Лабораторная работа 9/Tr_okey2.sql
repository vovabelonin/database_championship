--Добавление новых игроков в команду и отказ , при нарушении регламента турнира.
--регламент:Годом команды называется характеристика команды по возрасту игроков.
--Все игроки команды должны иметь год рождения, равный году команды. Игра
--одного игрока за две разные команды в течение сезона не допускается.

GO
If (object_id('PT_Insert_Check') is not null)
drop trigger PT_Insert_Check;

GO
--Если Добавляем игрока в команду, то год его рождения должен соответствовать и этот игрок нигде больше играть не должен
Create trigger PT_Insert_Check
on Player_team
Instead of Insert As
Set nocount on

Declare @all int, @Yes int

select @all= count(*) from inserted

Insert into player_team
select * from inserted as I
where exists (select * from player as P 
inner join TEAM as t on T.team_id=I.TEAM_ID 
where P.Player_ID=I.Player_id
and Year(P.BIRTHDAY)=T.TEAM_YEAR
) and not exists (select * from player_team as pt
where i.player_id = pt.player_id and i.season_id = pt.season_id)

Set @yes=@@ROWCOUNT 

Print 'Успешно добавлено строк - '+convert(varchar(20),@Yes)+' из '+convert(varchar(20),@all)
------------------------------------------------------------------------------------------------------
--Если меняем что-то в таблице соответствий игрока-команды-сезона, то  год его рождения должен соответствовать и этот игрок нигде больше играть не должен в другой команде в этом сезоне

GO
If (object_id('PT_PlayerUpdate_Check') is not null)
drop trigger PT_PlayerUpdate_Check;

GO

Create trigger PT_PlayerUpdate_Check
on Player_team
Instead of Update As
Set nocount on

Declare @all int, @Yes int

select @all= count(*) from inserted

Delete player_team
where exists ( 
select * from inserted as I
where exists (select * from player as P 
inner join TEAM as t on T.team_id=I.TEAM_ID 
where P.Player_ID=I.Player_id
and Year(P.BIRTHDAY )=T.TEAM_YEAR 
and I.RECORD_ID2 =PLAYER_TEAM.RECORD_ID2
)and not exists (select * from player_team as pt
where i.player_id = pt.player_id and i.season_id = pt.season_id))


Insert into player_team 
select * from inserted as I
where exists (select * from player as P 
inner join TEAM as t on T.team_id=I.TEAM_ID 
where P.Player_ID=I.Player_id
and Year(P.BIRTHDAY)=T.TEAM_YEAR 
) and not exists (select * from player_team as pt
where i.player_id = pt.player_id and i.season_id = pt.season_id)

Set @yes=@@ROWCOUNT 

Print 'Успешно обработано строк - '+convert(varchar(20),@Yes)+' из '+convert(varchar(20),@all)
----------------------------------------------------------------------------------------
go
If (object_id('PT_YearUpdate_check') is not null)
drop trigger PT_YearUpdate_check;

GO
--Если меняем дату рождения игрока, а он есть в командах, то такую смену нужно запретить.
Create trigger PT_YearUpdate_check
on Player
Instead of Update As
Set nocount on

Declare @all int, @Yes int

select @all= count(*) from inserted

Delete player
where exists ( 
select * from inserted as I
where exists (select * from player as P 
inner join TEAM as t on T.team_id=I.TEAM_ID 
where P.Player_ID=I.Player_id
and Year(P.BIRTHDAY )=T.TEAM_YEAR 
) or not exists (select * from player as P

where P.player_id=i.player_id 

Insert into player_team 
select * from inserted as I
where exists (select * from player as P 
inner join TEAM as t on T.team_id=I.TEAM_ID 
where P.Player_ID=I.Player_id
and Year(P.BIRTHDAY)=T.TEAM_YEAR 
)
Update player 

Set @yes=@@ROWCOUNT 

Print 'Успешно обработано строк - '+convert(varchar(20),@Yes)+' из '+convert(varchar(20),@all)

go
-------------------------------------------------------------------------------------------