--выбрать 5 игр  в которых разницах забитых и пропущенных была самая большая
select top 5 with ties
g.game_date,
TEAM_ID1 as team1,
TEAM_ID2 as team2,
score_t1,
Score_t2,
abs(score_t1-score_t2) as DiffResult
from game_big as g
inner join TEAM as t1 on t1.TEAM_ID=g.TEAM_ID1
inner join team as t2 on t2.TEAM_ID=g.TEAM_ID2
order by 6 desc