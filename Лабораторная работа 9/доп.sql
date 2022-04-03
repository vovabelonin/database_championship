--кто когда в какой базе какое представление создал

CREATE TABLE VIEWSS(
LoginName nvarchar(250),
AuditDateTime datetime,
DatabaseName nvarchar(250),
ViewName nvarchar(250),
)

GO
CREATE TRIGGER TRD
ON ALL SERVER
FOR CREATE_VIEW
AS
BEGIN
	DECLARE @EventData XML
	SELECT @EventData = EVENTDATA()

	INSERT INTO NewLb.dbo.VIEWSS
	(LoginName, AuditDateTime, DatabaseName, ViewName)
	VALUES(
	@EventData.value('(/EVENT_INSTANCE/LoginName)[1]', 'varchar(250)'),
	GetDate(),
	@EventData.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'varchar(250)'),
	@EventData.value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(250)')
	) 
END


GO
CREATE VIEW QQQ AS SELECT * FROM COACH

GO
SELECT * FROM VIEWSS
