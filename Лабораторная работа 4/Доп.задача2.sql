--так как тип данных роста в таблице varchar ,сделать так(не меняя тип данных в таблице),чтобы все работало норм.
--т.е. человек с ростом 99 не был выше 100+

select top 5 P.Player_id,p.lastname,p.name,max(convert(int,Pd.Growth)) as gg from player as P 
inner join PHYSICAL_DATA as PD on PD.player_id=P.Player_ID
group by P.Player_id,p.lastname,p.name
order by gg desc