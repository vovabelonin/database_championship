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
 