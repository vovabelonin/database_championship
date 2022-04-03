select *
from view_1 as v

join GAME_REPORT as gr on gr.GAME_ID=v.game_id
join player as p on p.PLAYER_ID=gr.PLAYER_ID
join game as g on gr.game_id=g.GAME_ID
join PLAYER_TEAM as pt on pt.PLAYER_ID=p.PLAYER_ID and v.season_id=pt.SEASON_ID
join GAME_REFEREES as r on r.GAME_ID=v.game_id and r.ROLE_OF_REFEREE = 'Главный судья'
