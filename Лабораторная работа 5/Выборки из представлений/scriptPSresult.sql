--вывести топ 5 у кого средние очки за игру наибольшие
select top 5
p.player_id,
p.season_id,
round(convert(decimal(18,4),sumscore)/convert(decimal(18,4),number)*100,0)/100 as average
from PS_Result as p
group by p.season_id,p.player_id,p.number,p.sumscore
order by average desc
