--запретить обновлять даты сезонов, у которых уже прописана дата окончания
--запретить добавлять игроков в команду не своего года
GO
IF (object_id('year_checker') IS NOT NULL)
  DROP TRIGGER year_checker;

GO
CREATE TRIGGER year_checker
ON player_team
INSTEAD OF insert AS
SET NOCOUNT ON
DECLARE @succeeded int, @all int, @failed int
SET @all = (SELECT count(player_id) FROM inserted)
MERGE player_team AS target
USING (
	SELECT team_id,player_id,season_id,record_id2
	FROM inserted
	WHERE team_id IN (
		SELECT team_id
		FROM player_team
		inner join team on team.team_id = player_team.team_id
		WHERE team.team_year = (select year(birthday) from player as p 
		where p.player_id = inserted.player_id)  and not exists (select top 1 1 from player_team  as pt where pt.record_id2 = inserted.record_id2))
		)
AS updated (team_id,player_id,season_id,record_id2)
ON (target.player_id = updated.player_id)
WHEN MATCHED THEN
INSERT VALUES (updated.team_id,updated.player_id,updated.season_id,updated.record_id2);--не дает matched инсертить
SET @succeeded = @@ROWCOUNT
IF (@succeeded = @all) 
	PRINT N'Строк успешно обновлено: ' + CAST(@succeeded AS nvarchar)
ELSE
	BEGIN
	SET @failed = @all - @succeeded
	PRINT N'Строк успешно обновлено: ' + CAST(@succeeded AS nvarchar)
	RAISERROR(N'Нельзя обновить строк: %d, так это противоречит правилам нашего турнира', 15, 15, @failed)
END

BEGIN TRAN
SELECT * FROM Season
UPDATE Season
SET end_date = GETDATE() + 1000000
WHERE season_id <= 1
SELECT * FROM Season
ROLLBACK