/*DROP LOGIN test
DROP USER test*/

CREATE LOGIN  test WITH PASSWORD = 'test'
CREATE USER test FOR LOGIN test
--exec sp_grantdbaccess 'test'
SELECT CURRENT_USER;--вывести текущего пользователя  
-------------------------------------------------------------------------
--Проверим, к чему сейчас имеет доступ созданный пользователь

EXECUTE AS USER = 'test'

SELECT * FROM Player -- не может читать из таблицы

UPDATE GAME_REPORT 
	SET SCORE_PLAYER = '100' 
	WHERE PLAYER_ID = '20' --не может обновлять

DELETE FROM runk
	WHERE RUNK_NAME = 'Мастер спорта' --не может удалять

REVERT
---------------------------------------------------------------------------
--Присвоить новому пользователю права SELECT, INSERT, UPDATE в полном объеме на одну таблицу
DENY SELECT ON sportschool TO test
GRANT INSERT, SELECT, UPDATE, DELETE ON sportschool TO test

EXECUTE AS USER = 'test'

SELECT * FROM SPORTSCHOOL --может читать

BEGIN TRAN
UPDATE SPORTSCHOOL
	SET SPORTSCHOOL_NAME = 'Спортшкола №1000'
	WHERE SPORTSCHOOL_NAME = 'Спортшкола №666'--может изменять
ROLLBACK
INSERT INTO [dbo].[SPORTSCHOOL] ([SPORTSCHOOL_ID],[SPORTSCHOOL_ADRESS],[SPORTSCHOOL_NAME])VALUES (123,'ул.Первомайская 30к7','Спортшкола №0');--может вставлять

DELETE FROM SPORTSCHOOL 
	WHERE SPORTSCHOOL_ID = 123 --может удалять

REVERT
----------------------------------------------------------------------------
--Для одной таблицы новому пользователю присвоим права SELECT и UPDATE только избранных столбцов.

GRANT SELECT, UPDATE ON game_report (score_player,game_id) TO test

EXECUTE AS USER = 'test'

SELECT * FROM GAME_REPORT --всё не может читать

SELECT game_id,score_player FROM GAME_REPORT --выделенные мной столбцы может

UPDATE GAME_REPORT
 	SET SCORE_PLAYER = 12 
	WHERE PLAYER_ID = 15 --нет доступа к столбцу player_id, поэтому не может обновить

REVERT
--------------------------------------------------------------------------------
--Для одной таблицы новому пользователю присвоим только право SELECT.

GRANT SELECT ON physical_data TO test

EXECUTE AS USER = 'test'

SELECT * FROM team --нет прав на эту таблицу, не читает

SELECT * FROM PHYSICAL_DATA --может читать

UPDATE SEASON_RATING 
	SET SEASON_PLACE = '9'
	WHERE TEAM_ID = 1      --нет прав на обновление

REVERT
-------------------------------------------------------------------------------
--Присвоим новому пользователю право доступа (SELECT) к представлению, созданному в лабораторной работе №5.

GRANT SELECT ON school TO test

EXECUTE AS USER = 'test'

SELECT * FROM school

REVERT
--------------------------------------------------------------------------------
--Создадим стандартную роль уровня базы данных.

CREATE ROLE testrole
---------------------------------------------------------------------------------
--Присвоим ей право доступа (UPDATE на некоторые столбцы) к представлению, созданному в лабораторной работе №5.
GRANT UPDATE ON  school(sportschool_id,sportschool_adress) TO testrole
---------------------------------------------------------------------------------
--Назначим новому пользователю созданную роль.
ALTER ROLE testrole ADD MEMBER test
----------------------------------------------------------------------------------
--Проверим выполненные действия.
EXECUTE AS USER = 'test'

BEGIN TRAN
UPDATE school SET sportschool_adress = 'Ул.Солнечная д12' WHERE SPORTSCHOOL_id = 10
ROLLBACK

REVERT
-------------------------------------------------------------------------------------
--Завершим работу.

ALTER ROLE testrole DROP MEMBER test

ALTER ROLE testrole DROP MEMBER testrole

DROP ROLE testrole

DROP USER test

DROP LOGIN test
