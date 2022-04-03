--���������� ����� ������� � ������� � ����� , ��� ��������� ���������� �������.
--���������:����� ������� ���������� �������������� ������� �� �������� �������.
--��� ������ ������� ������ ����� ��� ��������, ������ ���� �������. ����
--������ ������ �� ��� ������ ������� � ������� ������ �� �����������.

GO
If (object_id('PT_Insert_Check') is not null)
drop trigger PT_Insert_Check;

GO
--------------------------------------------------------------------------------------------
--���� ��������� ������ � �������, �� ��� ��� �������� ������ ��������������� � ���� ����� ����� ������ ������ �� ������
Create trigger PT_Insert_Check
on Player_team
Instead of Insert As
Set nocount on

Declare @all int, @Yes int

select @all= count(*) from inserted

Insert into player_team
select * from inserted as I
where exists (select * from player as P 
inner join TEAM as t on T.team_id=I.TEAM_ID 
where P.Player_ID=I.Player_id
and Year(P.BIRTHDAY)=T.TEAM_YEAR
) and not exists (select * from player_team as pt
where i.player_id = pt.player_id and i.season_id = pt.season_id)

Set @yes=@@ROWCOUNT 

Print '������� ��������� ����� - '+convert(varchar(20),@Yes)+' �� '+convert(varchar(20),@all)
------------------------------------------------------------------------------------------------------
--���� ������ ���-�� � ������� ������������ ������-�������-������, ��  ��� ��� �������� ������ ��������������� � ���� ����� ����� ������ ������ �� ������ � ������ ������� � ���� ������

GO
If (object_id('PT_PlayerUpdate_Check') is not null)
drop trigger PT_PlayerUpdate_Check;

GO

Create trigger PT_PlayerUpdate_Check
on Player_team
Instead of Update As
Set nocount on

Declare @all int, @Yes int

select @all= count(*) from inserted

Delete player_team
where exists ( 
select * from inserted as I
where exists (select * from player as P 
inner join TEAM as t on T.team_id=I.TEAM_ID 
where P.Player_ID=I.Player_id
and Year(P.BIRTHDAY )=T.TEAM_YEAR 
and I.RECORD_ID2 =PLAYER_TEAM.RECORD_ID2
)and not exists (select * from player_team as pt
where i.player_id = pt.player_id and i.season_id = pt.season_id))


Insert into player_team 
select * from inserted as I
where exists (select * from player as P 
inner join TEAM as t on T.team_id=I.TEAM_ID 
where P.Player_ID=I.Player_id
and Year(P.BIRTHDAY)=T.TEAM_YEAR 
) and not exists (select * from player_team as pt
where i.player_id = pt.player_id and i.season_id = pt.season_id)

Set @yes=@@ROWCOUNT 

Print '������� ���������� ����� - '+convert(varchar(20),@Yes)+' �� '+convert(varchar(20),@all)
----------------------------------------------------------------------------------------
--���� ������ ��� � �������, �� ��������, ���� ���� ���� ���� ����� ������� ���� (! ������ ������ ������ ���� � ������� ��� �� ������ ������)
GO
If (object_id('Team_Update_Check') is not null)
drop trigger Team_Update_Check;

GO

Create trigger Team_Update_Check
on Team
Instead of Update As
Set nocount on

Declare @all int, @Yes int

select @all= count(*) from inserted

Update Team 
Set
TEAM_ID =I.TEAM_id,
TEAM_NAME =I.TEAM_NAME ,
TEAM_YEAR =I.TEAM_YEAR 
From inserted as I
where 
I.TEAM_ID  =TEAM.TEAM_ID  
and
--����� ������ ������ ���� �� ����� ������� ����� ��� ����� ����������.
not exists (select top 1 * from PLAYER_TEAM as PT
		inner join Player as P on P.PLAYER_ID =PT.Player_ID
		where PT.TEam_ID=I.Team_ID 
		and I.TEAM_YEAR !=year(P.BIRTHDAY)
		)



Set @yes=@@ROWCOUNT 

Print '������� ���������� ����� - '+convert(varchar(20),@Yes)+' �� '+convert(varchar(20),@all)
-----------------------------------------------------------------------------------------------
--���� ������ ���� �������� ������, � �� ���� � ��������, �� ����� ����� ����� ���������.
GO
If (object_id('Player_Update_Check') is not null)
drop trigger Player_Update_Check;

GO

Create trigger Player_Update_Check
on Player
Instead of Update As
Set nocount on

Declare @all int, @Yes int

select @all= count(*) from inserted

Update PLAYER 
Set
Player_id=I.Player_id, --��������� ���� ���� ����� ���������
LASTNAME=i.LASTNAME, --���� ���� �������� �� ������������ � �����-�� �������, �� � ��� �� � �� ��������� ���. ��� �������. ������ ������ ���� �������� ������, � ������ �� ��������
NAME=I.name,
PATRONYMIC=I.PATRONYMIC, 
BIRTHDAY=I.BIRTHDAY 
From inserted as I
where 
I.PLAYER_ID =Player.PLAYER_ID 
and
(not exists (Select top 1 * from PLAYER_TEAM  as PT1 where PT1.Player_ID=I.Player_id) --��������� ������ ��� � ���� ��� ������ � ��������
OR
(exists (select top 1 * from PLAYER_TEAM as PT2 
		inner join team as T on T.Team_ID=PT2.Team_ID
		where PT2.Player_ID=I.PLAYER_ID 
		and T.TEAM_YEAR =year(I.BIRTHDAY)
		)--���� ���� ������ � ��������, �� ������ ������ � ��� �������, ����� ��� ����������
)
)


Set @yes=@@ROWCOUNT 

Print '������� ���������� ����� - '+convert(varchar(20),@Yes)+' �� '+convert(varchar(20),@all)

go







