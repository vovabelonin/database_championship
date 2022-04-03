/*
�������� �������� ��������������� ������� � ������ �������������� SQL ���� Microsoft SQL Server.
2. ���� ��� ��������������� ����������
�	��������� ��������������� ������� ����� SQL.
3. ���������� � ������
�	����������� ������ ��� ���������� ������, ��������� ��� ���������� ������������ ������ �2. ����� �������������� ������ ������ ���������� �� ����� 10 ����������� ��� ������ �� ���������� ��������� 
� 20 ����������� ��� ������ �� �������������.
�	����������� SQL-������� ��� �������� ������ � ���� ������*1.
�	��������� SQL-������� ��� ���������� �������, �������� � ����� �������� ��������������� �������, � ����� ��� 3-4 �������, ������� ����������� �������� ��� ���������� �������.
�	�������������� 3-4 ������� �� ��������� � �������� �� ���� ������. ������� ������ ���� �������������� � �������� ���������� �������. ����� �������� ����������� ������ ���� �����, 
������� ����� �������� ������������ ����������� �����������. ��������� SQL-������� ��� ���������� ���� ��������.
4. ���������� ������
�	��������� Microsoft Query Analyzer � ����������� � ��������� ����� ������.
�	��������� ������ �������� ������ � ����. ��������� �������� ���������� � �����.
�	��������� �������������� �������. ��������� �������� ���������� � �����.
�	��������� �������������� ������� �� ����������� ������. ��������� � ���������� ������������ ����������� �����������. ��������� �������, �������������� ������������ ���������� �����������. 
��������� �������� ���������� � �����.
�	��������� ������ � Microsoft SQL Server.
5. ���������� ������
�	�������� ������ � ����� Microsoft Query Analyzer.



�	������� ������ � �������, ������������� � ���� ���������� ������.
*/

-----------------------------------------------
--SQL-������� ��� ���������� �������
-----------------------------------------------

use sport

--������� 5 ����� ������� �������

select top 5 P.Player_id,p.lastname,p.name,max(convert(int,Pd.Growth)) as gg from player as P 
inner join PHYSICAL_DATA as PD on PD.player_id=P.Player_ID
group by P.Player_id,p.lastname,p.name
order by gg desc


--������� 5 ���  � ������� �������� ������� � ����������� ���� ����� �������
select top 5 
game_date,
T1.team_name as Team1,
T2.team_name as Team2,
Score_1team,
Score_2team,
abs(Score_1team-Score_2team) as DiffResult--����� ������ �������
from game as G
inner join Team as T1 on T1.Team_ID=G.team_ID1
inner join Team as T2 on T2.Team_ID=G.team_ID2
order by 6 desc

--������� ���� ������ ���� (�������, ��������,�����, ) ���������� � ������� ������, ����� ���������� ���������� �� �����
Select P.Lastname+' '+P.name+ ' '+P.patronymic as NName,day(P.birthday) as D,'�����' As CL, T.Team_name
from Player as P
Left join Player_team as PT on P.Player_id=PT.Player_id and Pt.Season_id=2
left join team as T on T.Team_ID=Pt.team_ID
where month(birthday)=MONTH (getdate())
Union
Select C.Lastname+' '+C.name+' '+C.patronymic as NName,day(C.birthday) as D, '������' As CL,Team_name 
from Coach as C
Left join Coach_team as CT on C.coach_id=cT.Coach_id and Ct.Season_id=2
left join team as T on T.Team_ID=Ct.team_ID
where month(birthday)=MONTH (getdate())
Union
Select Full_name as NName,day(birthday) as D,'�����' As CL,'' from referees where  month(birthday)=MONTH (getdate())
Order by D,NName

--������� ������� � ��������� ���-�� ������� � ������ ������
Select T.Team_name,  S.Season_year, count(*)
from Team as T
inner join Player_team as PT on PT.team_id=T.Team_ID
inner join Season as S on S.Season_ID=PT.Season_ID
group by T.Team_name, S.Season_year
order by 3 

--������� ��������� ���������� ������� ����� ������ �������� �� 2 ������
with a as (
select team_id1 as teamid, sum(score_1team) as S from game
/*where SEASON_ID = 2*/
group by TEAM_ID1
union all
select team_id2 as teamid, sum(score_2team) as S from game
/*where SEASON_ID = 2*/
group by TEAM_ID2
)
select TEAM_NAME,sum(S) as summa from a
inner join team on team.TEAM_ID=a.teamid
group by team.TEAM_NAME
order by summa desc

select * from game
------------------------------------------------------
--3-4 ������� �� ��������� � �������� �� ���� ������
------------------------------------------------------

--������� ���������� (� ������������ �����������)
delete SPORTSCHOOL where SPORTSCHOOL_NAME ='���������� �19' -- ������� ������
Select * from SPORTSCHOOL where SPORTSCHOOL_NAME ='���������� �19' --���������� ��� �� ���������

--������� ���������� �� �������
--������ ������, ������� ������, ����� ������, �������,  �����-�����
delete PLAYER_TEAM  where exists (select top 1 1 from team as t inner join SPORTSCHOOL as SS on SS.SPORTSCHOOL_ID =T.SPORTSCHOOL_ID and SPORTSCHOOL_NAME ='���������� �19' where t.TEAM_ID =PLAYER_TEAM.Team_ID)
delete COACH_TEAM  where exists (select top 1 1 from team as t inner join SPORTSCHOOL as SS on SS.SPORTSCHOOL_ID =T.SPORTSCHOOL_ID and SPORTSCHOOL_NAME ='���������� �19' where t.TEAM_ID =COACH_TEAM.Team_ID)
delete SEASON_RATING  where exists (select top 1 1 from team as t inner join SPORTSCHOOL as SS on SS.SPORTSCHOOL_ID =T.SPORTSCHOOL_ID and SPORTSCHOOL_NAME ='���������� �19' where t.TEAM_ID =SEASON_RATING.Team_ID)
delete Game  where exists (select top 1 1 from team as t inner join SPORTSCHOOL as SS on SS.SPORTSCHOOL_ID =T.SPORTSCHOOL_ID and SPORTSCHOOL_NAME ='���������� �19' where t.TEAM_ID =Game.TEAM_ID1)
delete Game  where exists (select top 1 1 from team as t inner join SPORTSCHOOL as SS on SS.SPORTSCHOOL_ID =T.SPORTSCHOOL_ID and SPORTSCHOOL_NAME ='���������� �19' where t.TEAM_ID =Game.Team_ID2)
delete team where exists (select top 1 1 from SPORTSCHOOL where SPORTSCHOOL.SPORTSCHOOL_ID =team.SPORTSCHOOL_ID and SPORTSCHOOL_NAME ='���������� �19')
delete COACH_TEAM  where exists (select top 1 1 from COACH as C inner join SPORTSCHOOL as SS on SS.SPORTSCHOOL_ID =C.SPORTSCHOOL_ID and SPORTSCHOOL_NAME ='���������� �19' where C.COACH_ID  =COACH_TEAM.COACH_ID)
delete COACH where exists (select top 1 1 from SPORTSCHOOL where SPORTSCHOOL.SPORTSCHOOL_ID =COACH.SPORTSCHOOL_ID and SPORTSCHOOL_NAME ='���������� �19')
delete SPORTSCHOOL where SPORTSCHOOL_NAME ='���������� �19'
--������� ������������� ����, ��� ������ ��������
Select * from SPORTSCHOOL where SPORTSCHOOL_NAME ='���������� �19' --���������� ��� ���������


--������� ������ ������� ������ (� ������������ �����������)�� ����������
Delete runk where RUNK_NAME ='������ ������'
select * from runk where RUNK_NAME ='������ ������'

--������� ������ �� ������� (������� ���������� ���, ����� ������� ������)
--������� ������������� ����, ��� ������ ��������
Update Player_runk
set Runk_ID=(select runk_id from runk where RUNK_NAME ='�������� � ��')
where runk_id=(select runk_id from runk where RUNK_NAME ='������ ������')
Delete runk where RUNK_NAME ='������ ������'
select * from runk 

-- ������� ������ �� ���� (� ������������ �����������) �� ��������
Delete player where year(birthday)>2003
select * from player where year(birthday)>2003

--������� ������ �� ������� (�� �������, ����� �� ����)
delete player_runk where exists (select top 1 1 from player where player.PLAYER_ID =PLAYER_RUNK .PLAYER_ID and year(player.birthday)>2003)
delete PHYSICAL_DATA where exists (select top 1 1 from player where player.PLAYER_ID =PHYSICAL_DATA.PLAYER_ID and year(player.birthday)>2003)
delete PLAYER_TEAM  where exists (select top 1 1 from player where player.PLAYER_ID =PLAYER_TEAM.PLAYER_ID and year(player.birthday)>2003)
Delete player where year(birthday)>2003
--������� ������������� ����, ��� ������ ��������
select * from player where year(birthday)>2003

--������ ������� � ������ ����� 160��
--����� 5 ������ ��������������� ������� �  � ����,��� ���������,������� ���� ������ � ���� ���

update PHYSICAL_DATA
set GROWTH = 202,WEIGHT = 93
where RECORD4_ID = 5

select * from PHYSICAL_DATA
--������ ����� �����,�������� �������
update coach
set LASTNAME = '�������'
where COACH_ID = 7

select*from COACH





