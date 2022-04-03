--Всем игрокам,команды которых забили более n очков за все игры,выдать на один разряд больше с подписью сегодняшней даты

declare @n integer
set @n=100

Insert into Player_runk
select distinct PR.Player_id, convert(varchar(20),getdate(),104),
(case when PR.runk_id-1>0 then PR.runk_id-1 else PR.runk_id end),
PR.RECORD5_ID+10000
from PLAYER_RUNK as PR
inner join Player_team as PT on PT.Player_ID=PR.Player_ID
inner join Team as T on T.TEAM_ID =PT.TEAM_ID
where exists (select top 1 1 from game as G where (G.TEAM_ID1 =T.Team_ID and G.SCORE_1TEAM >@N) or (G.TEAM_ID2 =T.Team_ID and G.SCORE_2TEAM >@N) )

