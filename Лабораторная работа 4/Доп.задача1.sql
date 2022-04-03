--выбрать всех членов лиги (игроков, тренеров,судей, ) родившихс€ в текущем мес€це, чтобы разместить объ€вление на сайте
--сделать так,чтобы пользователь обращалс€ не к id сезона ,а именно к году сезона.
Select P.Lastname+' '+P.name+ ' '+P.patronymic as NName,day(P.birthday) as D,'»грок' As CL, T.Team_name
from Player as P
Left join Player_team as PT on P.Player_id=PT.Player_id
inner join SEASON as S on pt.SEASON_ID=S.SEASON_ID
left join team as T on T.Team_ID=Pt.team_ID
where S.SEASON_YEAR = 2020 and month(birthday)=MONTH (getdate())
Union
Select C.Lastname+' '+C.name+' '+C.patronymic as NName,day(C.birthday) as D, '“ренер' As CL,Team_name 
from Coach as C
Left join Coach_team as CT on C.coach_id=cT.Coach_id
inner join SEASON as F on ct.SEASON_ID=F.SEASON_ID
left join team as T on T.Team_ID=Ct.team_ID
where F.SEASON_YEAR = 2020 and month(birthday)=MONTH (getdate())
Union
Select Full_name as NName,day(birthday) as D,'—удь€' As CL,'' from referees where  month(birthday)=MONTH (getdate())
Order by D,NName