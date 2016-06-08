set @var := 'pf';

set @qry := concat('
select  
		x.year,
        x.player,
        x.',@var,',
        y.',@var,',
        case when x.',@var,' = y.',@var,' then 0 else 1 end as ',@var,'_er

from player_totals_sum x
left join player_gmstat_sum y
on x.year = y.year and x.player = y.player
where x.year != 2016
/*group by x.year,
         x.player*/
having ',@var,'_er = 1
;');

prepare stmt from @qry;
execute stmt;