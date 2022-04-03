-- создать представления с итогами по игроку за сезон
use NewLb
if (OBJECT_ID ('PS_Result') IS NOT NULL)
  DROP VIEW PS_Result;
GO
CREATE VIEW PS_Result AS 
select
gr.PLAYER_ID,
g.SEASON_ID,
pt.TEAM_ID,
count(*) as number,
max(score_player) as maxscore,
min(score_player) as minscore,
sum(score_player) as sumscore

FROM GAME_REPORT as gr
inner join game as g on g.GAME_ID=gr.GAME_ID
inner join PLAYER_TEAM as pt on pt.PLAYER_ID=gr.PLAYER_ID
inner join TEAM as t on t.TEAM_ID=pt.TEAM_ID and pt.SEASON_ID=g.SEASON_ID
group by gr.PLAYER_ID,g.SEASON_ID,pt.TEAM_ID
