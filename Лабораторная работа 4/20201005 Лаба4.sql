/*
Освоение способов манипулирования данными в средах интерактивного SQL СУБД Microsoft SQL Server.
2. Темы для предварительной проработки
•	Операторы манипулирования данными языка SQL.
3. Подготовка к работе
•	Подготовить данные для заполнения таблиц, созданных при выполнении лабораторной работы №2. Объем подготовленных данных должен составлять не менее 10 экземпляров для каждой из стержневых сущностей 
и 20 экземпляров для каждой из ассоциативных.
•	Подготовить SQL-скрипты для внесения данных в базу данных*1.
•	Составить SQL-скрипты для выполнения выборок, заданных в Вашем варианте индивидуального задания, а также еще 3-4 выборок, имеющих осмысленное значение для предметной области.
•	Сформулировать 3-4 запроса на изменение и удаление из базы данных. Запросы должны быть сформулированы в терминах предметной области. Среди запросов обязательно должны быть такие, 
которые будут вызывать срабатывание ограничений целостности. Составить SQL-скрипты для выполнения этих запросов.
4. Выполнение работы
•	Запустить Microsoft Query Analyzer и соединиться с локальной базой данных.
•	Выполнить скрипт внесения данных в базу. Сохранить протокол выполнения в файле.
•	Выполнить подготовленные выборки. Сохранить протокол выполнения в файле.
•	Выполнить подготовленные запросы на модификацию данных. Убедиться в правильном срабатывании ограничений целостности. Выполнить выборки, подтверждающие правильность выполнения модификаций. 
Сохранить протокол выполнения в файле.
•	Закончить работу с Microsoft SQL Server.
5. Содержание отчета
•	Протокол работы в среде Microsoft Query Analyzer.



•	Краткие выводы о навыках, приобретенных в ходе выполнения работы.
*/

-----------------------------------------------
--SQL-скрипты для выполнения выборок
-----------------------------------------------

use sport

--выбрать 5 самых высоких игроков

select top 5 P.Player_id,p.lastname,p.name,max(convert(int,Pd.Growth)) as gg from player as P 
inner join PHYSICAL_DATA as PD on PD.player_id=P.Player_ID
group by P.Player_id,p.lastname,p.name
order by gg desc


--выбрать 5 игр  в которых разницах забитых и пропущенных была самая большая
select top 5 
game_date,
T1.team_name as Team1,
T2.team_name as Team2,
Score_1team,
Score_2team,
abs(Score_1team-Score_2team) as DiffResult--берем модуль разницы
from game as G
inner join Team as T1 on T1.Team_ID=G.team_ID1
inner join Team as T2 on T2.Team_ID=G.team_ID2
order by 6 desc

--выбрать всех членов лиги (игроков, тренеров,судей, ) родившихся в текущем месяце, чтобы разместить объявление на сайте
Select P.Lastname+' '+P.name+ ' '+P.patronymic as NName,day(P.birthday) as D,'Игрок' As CL, T.Team_name
from Player as P
Left join Player_team as PT on P.Player_id=PT.Player_id and Pt.Season_id=2
left join team as T on T.Team_ID=Pt.team_ID
where month(birthday)=MONTH (getdate())
Union
Select C.Lastname+' '+C.name+' '+C.patronymic as NName,day(C.birthday) as D, 'Тренер' As CL,Team_name 
from Coach as C
Left join Coach_team as CT on C.coach_id=cT.Coach_id and Ct.Season_id=2
left join team as T on T.Team_ID=Ct.team_ID
where month(birthday)=MONTH (getdate())
Union
Select Full_name as NName,day(birthday) as D,'Судья' As CL,'' from referees where  month(birthday)=MONTH (getdate())
Order by D,NName

--Вывести команды с указанием кол-ва игроков в каждом сезоне
Select T.Team_name,  S.Season_year, count(*)
from Team as T
inner join Player_team as PT on PT.team_id=T.Team_ID
inner join Season as S on S.Season_ID=PT.Season_ID
group by T.Team_name, S.Season_year
order by 3 

--выведем суммарное количество забитых очков каждой командой за 2 сезона
with a as (
select team_id1 as teamid, sum(score_1team) as S from game
/*where SEASON_ID = 2*/
group by TEAM_ID1
union all
select team_id2 as teamid, sum(score_2team) as S from game
/*where SEASON_ID = 2*/
group by TEAM_ID2
)
select TEAM_NAME,sum(S) as summa from a
inner join team on team.TEAM_ID=a.teamid
group by team.TEAM_NAME
order by summa desc

select * from game
------------------------------------------------------
--3-4 запроса на изменение и удаление из базы данных
------------------------------------------------------

--удалить спортшколу (С ограничением целостности)
delete SPORTSCHOOL where SPORTSCHOOL_NAME ='Спортшкола №19' -- вернула ошибку
Select * from SPORTSCHOOL where SPORTSCHOOL_NAME ='Спортшкола №19' --показываем что не удалилась

--удалить спортшколу по порядку
--Игроки команд, тренеры команд, места команд, команды,  спорт-школа
delete PLAYER_TEAM  where exists (select top 1 1 from team as t inner join SPORTSCHOOL as SS on SS.SPORTSCHOOL_ID =T.SPORTSCHOOL_ID and SPORTSCHOOL_NAME ='Спортшкола №19' where t.TEAM_ID =PLAYER_TEAM.Team_ID)
delete COACH_TEAM  where exists (select top 1 1 from team as t inner join SPORTSCHOOL as SS on SS.SPORTSCHOOL_ID =T.SPORTSCHOOL_ID and SPORTSCHOOL_NAME ='Спортшкола №19' where t.TEAM_ID =COACH_TEAM.Team_ID)
delete SEASON_RATING  where exists (select top 1 1 from team as t inner join SPORTSCHOOL as SS on SS.SPORTSCHOOL_ID =T.SPORTSCHOOL_ID and SPORTSCHOOL_NAME ='Спортшкола №19' where t.TEAM_ID =SEASON_RATING.Team_ID)
delete Game  where exists (select top 1 1 from team as t inner join SPORTSCHOOL as SS on SS.SPORTSCHOOL_ID =T.SPORTSCHOOL_ID and SPORTSCHOOL_NAME ='Спортшкола №19' where t.TEAM_ID =Game.TEAM_ID1)
delete Game  where exists (select top 1 1 from team as t inner join SPORTSCHOOL as SS on SS.SPORTSCHOOL_ID =T.SPORTSCHOOL_ID and SPORTSCHOOL_NAME ='Спортшкола №19' where t.TEAM_ID =Game.Team_ID2)
delete team where exists (select top 1 1 from SPORTSCHOOL where SPORTSCHOOL.SPORTSCHOOL_ID =team.SPORTSCHOOL_ID and SPORTSCHOOL_NAME ='Спортшкола №19')
delete COACH_TEAM  where exists (select top 1 1 from COACH as C inner join SPORTSCHOOL as SS on SS.SPORTSCHOOL_ID =C.SPORTSCHOOL_ID and SPORTSCHOOL_NAME ='Спортшкола №19' where C.COACH_ID  =COACH_TEAM.COACH_ID)
delete COACH where exists (select top 1 1 from SPORTSCHOOL where SPORTSCHOOL.SPORTSCHOOL_ID =COACH.SPORTSCHOOL_ID and SPORTSCHOOL_NAME ='Спортшкола №19')
delete SPORTSCHOOL where SPORTSCHOOL_NAME ='Спортшкола №19'
--вывести подтверждение того, что данные изменены
Select * from SPORTSCHOOL where SPORTSCHOOL_NAME ='Спортшкола №19' --показываем что удалилась


--удалить звание мастера спорта (С ограничением целостности)не получается
Delete runk where RUNK_NAME ='Мастер Спорта'
select * from runk where RUNK_NAME ='Мастер Спорта'

--удалить звание по порядку (игрокам проставить кмс, потом удалить звание)
--вывести подтверждение того, что данные изменены
Update Player_runk
set Runk_ID=(select runk_id from runk where RUNK_NAME ='Кандидат в МС')
where runk_id=(select runk_id from runk where RUNK_NAME ='Мастер Спорта')
Delete runk where RUNK_NAME ='Мастер Спорта'
select * from runk 

-- удалить игрока из базы (С ограничением целостности) не работает
Delete player where year(birthday)>2003
select * from player where year(birthday)>2003

--удалить игрока по порядку (из команды, потом из базы)
delete player_runk where exists (select top 1 1 from player where player.PLAYER_ID =PLAYER_RUNK .PLAYER_ID and year(player.birthday)>2003)
delete PHYSICAL_DATA where exists (select top 1 1 from player where player.PLAYER_ID =PHYSICAL_DATA.PLAYER_ID and year(player.birthday)>2003)
delete PLAYER_TEAM  where exists (select top 1 1 from player where player.PLAYER_ID =PLAYER_TEAM.PLAYER_ID and year(player.birthday)>2003)
Delete player where year(birthday)>2003
--вывести подтверждение того, что данные изменены
select * from player where year(birthday)>2003

--удалим игроков с ростом менее 160см
--игрок 5 прошел медобследование сегодня и  и рост,вес поменялся,изменим дату измера и рост вес

update PHYSICAL_DATA
set GROWTH = 202,WEIGHT = 93
where RECORD4_ID = 5

select * from PHYSICAL_DATA
--Тренер вышла замуж,поменяла фамилию
update coach
set LASTNAME = 'Ханжина'
where COACH_ID = 7

select*from COACH





