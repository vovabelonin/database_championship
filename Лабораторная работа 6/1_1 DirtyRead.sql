--1.1 ������� ������
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED--����� ������ � �������� �������
--SET TRANSACTION ISOLATION LEVEL READ COMMITTED--����� �����, �� ��������� ������ ������ ������. �������������� ����� ���������� ��� ������ ������� ����� ������������ ����������
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