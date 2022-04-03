--вывести топ 3 тренеров,у которых наибольший  процент побед

select top 3
COACH_id,
lastname,
SEASON_id,
count(*) as n,
sum(iswin) as w,
convert(decimal,sum(iswin))/convert(decimal,count(*)) as att
from coach_analyt
group by COACH_id,lastname,SEASON_id
order by att desc

