--SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
--SET TRANSACTION ISOLATION LEVEL SERIALIZABLE


BEGIN TRANSACTION

UPDATE GAME_REPORT SET SCORE_PLAYER = 400 WHERE PLAYER_ID  = 2 and GAME_ID = 1 

UPDATE GAME_REPORT SET SCORE_PLAYER = 400 WHERE PLAYER_ID  = 1  and GAME_ID = 1 

select * FROM GAME_REPORT WHERE PLAYER_ID  = 1 and GAME_ID = 1 OR PLAYER_ID  = 2  and GAME_ID = 1 

COMMIT

select * FROM GAME_REPORT WHERE PLAYER_ID  = 1 and GAME_ID = 1 OR PLAYER_ID  = 2  and GAME_ID = 1 