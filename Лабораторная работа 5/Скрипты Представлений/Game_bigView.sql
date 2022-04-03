--выдать информацию по игре с указанием:
--очки набранные каждой командой
use NewLb
if (OBJECT_ID ('game_big') IS NOT NULL)
  DROP VIEW game_big;
GO
CREATE VIEW game_big AS 
select 
g.GAME_ID,
g.SEASON_ID,
g.game_date,
g.TEAM_ID1,
g.TEAM_ID2,
(select sum(Gr1.SCORE_PLAYER) from GAME_REPORT as GR1 
inner join player_team as PT1 on PT1.PLAYER_ID =GR1.Player_id
where Gr1.GAME_ID =G.GAME_ID and PT1.SEASON_ID =G.SEASON_ID and Pt1.TEAM_ID=G.TEAM_ID1 ) as Score_t1,

(select sum(Gr2.SCORE_PLAYER) from GAME_REPORT as GR2 
inner join player_team as PT2 on PT2.PLAYER_ID =GR2.Player_id
where Gr2.GAME_ID =G.GAME_ID and PT2.SEASON_ID =G.SEASON_ID and Pt2.TEAM_ID=G.TEAM_ID2 ) as Score_t2

from game as G 


