--статистика по тренерам
-- вывести для каждого тренера в каждом сезоне по всем его играм: счет и команду соперника.
use NewLb
if (OBJECT_ID ('Coach_Analyt') IS NOT NULL)
  DROP VIEW Coach_Analyt;
GO
CREATE VIEW Coach_Analyt AS 
select 
C.COACH_ID,
c.LASTNAME ,
ct.SEASON_ID ,
v.Score_t1 as OurScore,
v.TEAM_ID1 as OurTeam,
V.Score_t2 as EnemyScore,
V.Team_id2 as EnemyTeam,
(Case when V.Score_t1>V.Score_t2 then 1 else 0 end) as IsWin
from COACH as C
inner join COACH_TEAM as ct on ct.COACH_ID=c.COACH_ID
inner join game_big as v on v.TEAM_ID1=ct.TEAM_ID and v.SEASON_ID=ct.SEASON_ID

union all 

select 
C.COACH_ID,
C.LASTNAME ,
ct.SEASON_ID ,
v.Score_t2 as OurScore,
v.TEAM_ID2 as OurTeam,
V.Score_t1 as EnemyScore,
V.Team_id1 as EnemyTeam,
(Case when V.Score_t2>V.Score_t1 then 1 else 0 end) as IsWin

from COACH as C
inner join COACH_TEAM as ct on ct.COACH_ID=c.COACH_ID
inner join game_big as v on v.TEAM_ID2=ct.TEAM_ID and v.SEASON_ID=ct.SEASON_ID

