--запретить обновлять даты сезонов, у которых уже прописана дата окончания
--обновлять тем,у кого появился новый рекорд или добавлять тем,у кого рекорда не было
GO
IF (object_id('new_record') IS NOT NULL)
  DROP TRIGGER new_record;

GO
CREATE TRIGGER new_record
ON game_report
INSTEAD OF insert AS
SET NOCOUNT ON
DECLARE @succeeded int, @all int, @failed int
SET @all = (SELECT count(player_id) FROM inserted)
-------
if exists(select * from inserted as i
inner join GAME_RECORDS on GAME_RECORDS.PLAYER_ID=i.PLAYER_ID
where i.player_id = GAME_RECORDS.PLAYER_ID) and inserted.score_player >


-------
SET @succeeded = @@ROWCOUNT
IF (@succeeded = @all) 
	PRINT N'Строк успешно обновлено: ' + CAST(@succeeded AS nvarchar)
ELSE
	BEGIN
	SET @failed = @all - @succeeded
	PRINT N'Строк успешно обновлено: ' + CAST(@succeeded AS nvarchar)
END

BEGIN TRAN
SELECT * FROM game_records
UPDATE game_records
SET new_recor = GETDATE() + 1000000
WHERE season_id <= 1
SELECT * FROM game_records
ROLLBACK