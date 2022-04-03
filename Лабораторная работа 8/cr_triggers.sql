CREATE TRIGGER Reminder_P1
ON tuser.Player1
AFTER INSERT, UPDATE 
AS RAISERROR ('Попытка изменеия игроков', 16, 10); 
GO

CREATE TRIGGER Reminder_P
ON dbo.Player1
AFTER INSERT, UPDATE 
AS RAISERROR ('Попытка изменеия игроков', 16, 10); 
GO