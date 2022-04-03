use NewLb
if (OBJECT_ID ('VIEW_1') IS NOT NULL)
  DROP VIEW VIEW_1;
GO
CREATE VIEW VIEW_1 AS 

SELECT 
PT.Team_id,GR.GAME_ID ,sum(Gr.score_player) as Team_score,g.GAME_DATE,g.SEASON_ID

  FROM GAME_REPORT as GR
  inner join Game as G on G.Game_ID=GR.game_ID
  inner join player_team as PT on PT.PLAYER_ID =Gr.PLAYER_ID and PT.SEASON_ID =G.SEASON_ID
  --inner join SEASON as S on s.SEASON_ID=G.SEASON_ID
  group by PT.Team_id,GR.GAME_ID,g.GAME_DATE,g.SEASON_ID
 --order by 2