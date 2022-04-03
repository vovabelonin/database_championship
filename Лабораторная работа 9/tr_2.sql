--запретить обновлять даты сезонов, у которых уже прописана дата окончания

GO
IF (object_id('Season_dates_update') IS NOT NULL)
  DROP TRIGGER Season_dates_update;

GO
CREATE TRIGGER Season_dates_update
ON Season
INSTEAD OF UPDATE AS
SET NOCOUNT ON
DECLARE @succeeded int, @all int, @failed int
SET @all = (SELECT count(season_id) FROM inserted)
MERGE Season AS target
USING (
	SELECT season_id, start_date, end_date
	FROM inserted
	WHERE season_id IN (
		SELECT season_id
		FROM Season
		WHERE end_date IS NULL)
		)
AS updated (season_id, start_date, end_date)
ON (target.season_id = updated.season_id)
WHEN MATCHED THEN
UPDATE
	SET start_date = updated.start_date,
		end_date = updated.end_date;
SET @succeeded = @@ROWCOUNT
IF (@succeeded = @all) 
	PRINT N'Строк успешно обновлено: ' + CAST(@succeeded AS nvarchar)
ELSE
	BEGIN
	SET @failed = @all - @succeeded
	PRINT N'Строк успешно обновлено: ' + CAST(@succeeded AS nvarchar)
	RAISERROR(N'Нельзя обновить строк: %d, так даты окончания этих сезонов уже согласованы', 15, 15, @failed)
END

BEGIN TRAN
SELECT * FROM Season
UPDATE Season
SET end_date = GETDATE() + 1000000
WHERE season_id = 1
UPDATE Season
SET end_date = GETDATE() + 1000000
WHERE season_id = 2
SELECT * FROM Season
ROLLBACK
