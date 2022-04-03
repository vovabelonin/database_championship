/*Update Player_runk
set Runk_ID=(select runk_id from runk where RUNK_NAME ='Кандидат в МС')
where runk_id=(select runk_id from runk where RUNK_NAME ='Мастер Спорта')
Delete runk where RUNK_NAME ='Мастер Спорта'
select * from runk 
select * from PLAYER_RUNK
*/

update PHYSICAL_DATA
set GROWTH = 202,WEIGHT = 93, RESULT_DATE = getdate()
where PLAYER_ID = 5

select * from PHYSICAL_DATA