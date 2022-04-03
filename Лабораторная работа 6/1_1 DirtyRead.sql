--1.1 Грязное чтение
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED--будет читать с грязными данными
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED--будет ждать, но прочитает только чистые данные. Действительные после выполнения или отмены начатой ранее параллельной транзакции
--SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
--SET TRANSACTION ISOLATION LEVEL SERIALIZABLE


BEGIN TRAN

select * from GAME_REPORT
where (PLAYER_ID = 9 or PLAYER_ID = 1) and GAME_ID = 1
--
select * from GAME_REPORT
where (PLAYER_ID = 9 or PLAYER_ID = 1) and GAME_ID = 1
--
select * from GAME_REPORT
where (PLAYER_ID = 9 or PLAYER_ID = 1) and GAME_ID = 1

COMMIT