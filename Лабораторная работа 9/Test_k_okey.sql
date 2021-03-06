--------------------------------------------------------
--ТРИГГЕР ПРОВЕРКА ПЕРВОГО

--добавляем двоих по очереди в команду 2004г
insert into PLAYER_TEAM --из 2002-го и нет в player_team
Select 6,--team
84,--player
2,--season
max(record_id2)+1
 from player_team --не сделалась


insert into PLAYER_TEAM --из 2004-го
Select 6,--team
88,--player
2,--season
max(record_id2)+1
 from player_team --сделалась

 --добавляем игрока 2002,принадлежащего команде -- не работает
 insert into PLAYER_TEAM --из 2004-го
Select 6,--team
10,--player
2,--season
max(record_id2)+1
 from player_team 

  --добавляем игрока 2004,принадлежащего команде--не работает
 insert into PLAYER_TEAM --из 2004-го
Select 6,--team
50,--player
2,--season
max(record_id2)+1
 from player_team 

--добавляем группу товарищей
Declare @ID integer
 select @ID=max (record_id2) from PLAYER_TEAM 

insert into player_team 
select 
3,--team
p.Player_id,--player
2,--season,
@ID+p.player_id
from player as P where player_id in (86,87,88,89,100,40,41)--86 87 должны добавиться,остальные нет
 -------------------------------------------------------------------------------------------------
 --ПРОВЕРКА ТРИГГЕРА ВТОРОГО
 Select * from PLAYER_TEAM where Team_id=5 and SEASON_ID =2
 --<=80 есть в команде
--меняем двоих по очереди 
--89-го 2004 вместо 41-го 2004 -  должно получиться
--84-го 2002 вместо 42-го 2004 -  не должно получиться
--44-го 2004 вместо 43-го 2004 -  не должно получиться
--1-го 2002 вместо 45-го 2004 -   не должно получиться
--2-го 2002 вместо 90-го 2004 -   не должно получиться
Update PLAYER_TEAM Set Player_ID=89 where Player_ID=41 and team_ID=5 and SEASON_ID =2 -- должно
Update PLAYER_TEAM Set Player_ID=84 where Player_ID=42 and team_ID=5 and SEASON_ID =2 --не должно
Update PLAYER_TEAM Set Player_ID=44 where Player_ID=43 and team_ID=5 and SEASON_ID =2 --не должно
Update PLAYER_TEAM Set Player_ID=1 where Player_ID=45 and team_ID=5 and SEASON_ID =2 --не должно
Update PLAYER_TEAM Set Player_ID=2 where Player_ID=90 and team_ID=5 and SEASON_ID =2 --не должно
--меняем Четверых в одном запросе 
Update PLAYER_TEAM 
Set Player_ID= (case Player_id 
when 41 then 89
when 42 then 84
when 43 then 44
when 45 then 1
else 2
end) 
where Player_ID in (41,42,43,45,90) 
and team_ID=5 and SEASON_ID =2

Select * from PLAYER_TEAM where Team_id=5 and SEASON_ID =2 
select * from player_team order by record_id2 desc
---------------------------------------------------------------------------
--ПРОВЕРКА ТРИГГЕРА ТРЕТЬЕГО
select * from team 


--меняем год команды на другой для пустой команды
Update TEAM  Set team_year=2003 where team_id=9 --восток

--меняем год команды на другой для полной команды
Update TEAM  Set team_year=2005 where team_id=5 --руна


--меняем всем годы в этом запросе
Update Team Set Team_Year=2005
--изменится только у номера 9 
Select * from TEAM 
----------------------------------------------------------------------------------
--ПРОВЕРКА ТРИГГЕРА ЧЕТВЕРТОГО
--Select * from PLAYER_TEAM where Team_id=5 and SEASON_ID =2

Select * from Player where PLAYER_ID in (46,47,48,49,50)
/*
PLAYER_ID	LASTNAME	NAME	PATRONYMIC	BIRTHDAY
46	Гусев	Сергей	Антонович	2004-10-11
47	Гусев	Виктор	Алексеевич	2004-11-12
48	Горохов	Антон	Николаевич	2004-12-13
49	Гамзатов	Антон	Алексеевич	2004-01-04
50	Волков	Андрей	Сергеевич	2004-02-05
- в исходное состояние
Update Player Set BIRTHDAY='2004-10-11' where Player_id= 46
Update Player Set BIRTHDAY='2004-11-12' where Player_id=47
Update Player Set BIRTHDAY='2004-12-13' where Player_id=48
Update Player Set BIRTHDAY='2004-01-04' where Player_id=49
Update Player Set BIRTHDAY='2004-02-05' where Player_id=50
*/

--меняем дату рождения на тот же год 
Update PLAYER Set BIRTHDAY ='2004-05-05' where Player_ID=46 

--меняем дату рождения на другой год
Update PLAYER Set BIRTHDAY ='2003-01-01' where Player_ID=47

--меняем Четверых в одном запросе. Кроме даты, меняем еще и Имя, для проверки 
Update PLAYER
Set 
Name = Name+' Второй',
BIRTHDAY = (case PLAYER_ID 
when 46 then '2004-11-11'
when 47 then '2004-07-07'
when 48 then '2005-08-08'
else '2003-06-06'
end ) 
where PLAYER_ID in (46,47,48,49)

Select * from Player where PLAYER_ID in (46,47,48,49,50)



































-- delete PLAYER_TEAM where RECORD_ID >160
/*
81	Петров	Сергей	Альбертович	2002-05-05
82	Иванов	Виктор	Антонович	2002-06-06
83	Юзов	Антон	Федорович	2002-07-07
84	Сидоров	Антон	Николаевич	2002-08-08
85	Александров	Андрей	Сергеевич	2002-09-09
86	Топоров	Иван	Николаевич	2002-03-04
87	Лебедев	Иван	Сергеевич	2002-04-05
88	Аверьев	Петр	Глебович	2004-05-15
89	Белов	Сергей	Федорович	2004-07-12
90	Балабанов	Илья	Ильич	2004-10-30
91	Хлебов	Олег	Альбертович	2004-11-13
92	Смирнов	Иван	Альбертович	2004-12-16
93	Михайлов	Михаил	Иванович	2004-02-10
94	Игнатьев	Иван	Альбертович	2004-06-29
*/