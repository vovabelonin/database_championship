--1.2 �������� ������� ������
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED-
--SET TRANSACTION ISOLATION LEVEL REPEATABLE READ-
--SET TRANSACTION ISOLATION LEVEL SERIALIZABLE-


begin tran 
	update GAME_REPORT
set SCORE_PLAYER = SCORE_PLAYER + 5
where player_id = 1 and GAME_ID = 1
	update GAME_REPORT
set SCORE_PLAYER = SCORE_PLAYER - 5
where player_id = 9 and GAME_ID = 1

--
rollback

