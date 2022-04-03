/*DROP LOGIN test
DROP USER test*/

CREATE LOGIN  test WITH PASSWORD = 'test'
CREATE USER test FOR LOGIN test
--exec sp_grantdbaccess 'test'
SELECT CURRENT_USER;--������� �������� ������������  
-------------------------------------------------------------------------
--��������, � ���� ������ ����� ������ ��������� ������������

EXECUTE AS USER = 'test'

SELECT * FROM Player -- �� ����� ������ �� �������

UPDATE GAME_REPORT 
	SET SCORE_PLAYER = '100' 
	WHERE PLAYER_ID = '20' --�� ����� ���������

DELETE FROM runk
	WHERE RUNK_NAME = '������ ������' --�� ����� �������

REVERT
---------------------------------------------------------------------------
--��������� ������ ������������ ����� SELECT, INSERT, UPDATE � ������ ������ �� ���� �������
DENY SELECT ON sportschool TO test
GRANT INSERT, SELECT, UPDATE, DELETE ON sportschool TO test

EXECUTE AS USER = 'test'

SELECT * FROM SPORTSCHOOL --����� ������

BEGIN TRAN
UPDATE SPORTSCHOOL
	SET SPORTSCHOOL_NAME = '���������� �1000'
	WHERE SPORTSCHOOL_NAME = '���������� �666'--����� ��������
ROLLBACK
INSERT INTO [dbo].[SPORTSCHOOL] ([SPORTSCHOOL_ID],[SPORTSCHOOL_ADRESS],[SPORTSCHOOL_NAME])VALUES (123,'��.������������ 30�7','���������� �0');--����� ���������

DELETE FROM SPORTSCHOOL 
	WHERE SPORTSCHOOL_ID = 123 --����� �������

REVERT
----------------------------------------------------------------------------
--��� ����� ������� ������ ������������ �������� ����� SELECT � UPDATE ������ ��������� ��������.

GRANT SELECT, UPDATE ON game_report (score_player,game_id) TO test

EXECUTE AS USER = 'test'

SELECT * FROM GAME_REPORT --�� �� ����� ������

SELECT game_id,score_player FROM GAME_REPORT --���������� ���� ������� �����

UPDATE GAME_REPORT
 	SET SCORE_PLAYER = 12 
	WHERE PLAYER_ID = 15 --��� ������� � ������� player_id, ������� �� ����� ��������

REVERT
--------------------------------------------------------------------------------
--��� ����� ������� ������ ������������ �������� ������ ����� SELECT.

GRANT SELECT ON physical_data TO test

EXECUTE AS USER = 'test'

SELECT * FROM team --��� ���� �� ��� �������, �� ������

SELECT * FROM PHYSICAL_DATA --����� ������

UPDATE SEASON_RATING 
	SET SEASON_PLACE = '9'
	WHERE TEAM_ID = 1      --��� ���� �� ����������

REVERT
-------------------------------------------------------------------------------
--�������� ������ ������������ ����� ������� (SELECT) � �������������, ���������� � ������������ ������ �5.

GRANT SELECT ON school TO test

EXECUTE AS USER = 'test'

SELECT * FROM school

REVERT
--------------------------------------------------------------------------------
--�������� ����������� ���� ������ ���� ������.

CREATE ROLE testrole
---------------------------------------------------------------------------------
--�������� �� ����� ������� (UPDATE �� ��������� �������) � �������������, ���������� � ������������ ������ �5.
GRANT UPDATE ON  school(sportschool_id,sportschool_adress) TO testrole
---------------------------------------------------------------------------------
--�������� ������ ������������ ��������� ����.
ALTER ROLE testrole ADD MEMBER test
----------------------------------------------------------------------------------
--�������� ����������� ��������.
EXECUTE AS USER = 'test'

BEGIN TRAN
UPDATE school SET sportschool_adress = '��.��������� �12' WHERE SPORTSCHOOL_id = 10
ROLLBACK

REVERT
-------------------------------------------------------------------------------------
--�������� ������.

ALTER ROLE testrole DROP MEMBER test

ALTER ROLE testrole DROP MEMBER testrole

DROP ROLE testrole

DROP USER test

DROP LOGIN test
