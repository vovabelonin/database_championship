
select 
p.PLAYER_ID,
p.LASTNAME,
p.NAME,
p.PATRONYMIC,
gr.GAME_ID,
v.score_t1,v.score_t2,
g.GAME_DATE,
gr.SCORE_PLAYER,
pt.TEAM_ID as HisTeam,
(case when pt.TEAM_ID = g.TEAM_ID1 then g.TEAM_ID2 else g.TEAM_ID1 end) as enemyteam,
(case when v.score_t1 > v.score_t2 then g.TEAM_ID1 else g.TEAM_ID2 end) as TeamWinner,
r.REFEREES_ID as GeneralJudge

from view_1 as v

join GAME_REPORT as gr on gr.GAME_ID=v.game_id
join player as p on p.PLAYER_ID=gr.PLAYER_ID
join game as g on gr.game_id=g.GAME_ID
join PLAYER_TEAM as pt on pt.PLAYER_ID=p.PLAYER_ID and v.season_id=pt.SEASON_ID
join GAME_REFEREES as r on r.GAME_ID=v.game_id and r.ROLE_OF_REFEREE = 'Главный судья'
group by p.PLAYER_ID,
p.LASTNAME,
p.NAME,
p.PATRONYMIC,
gr.GAME_ID,
v.score_t1,v.score_t2,
g.GAME_DATE,
gr.SCORE_PLAYER,
pt.TEAM_ID,g.TEAM_ID1,g.TEAM_ID2,r.REFEREES_ID