/*Update Player_runk
set Runk_ID=(select runk_id from runk where RUNK_NAME ='�������� � ��')
where runk_id=(select runk_id from runk where RUNK_NAME ='������ ������')
Delete runk where RUNK_NAME ='������ ������'
select * from runk 
select * from PLAYER_RUNK
*/

update PHYSICAL_DATA
set GROWTH = 202,WEIGHT = 93, RESULT_DATE = getdate()
where PLAYER_ID = 5

select * from PHYSICAL_DATA