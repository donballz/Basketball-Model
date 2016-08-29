/* 
Pulls specific year/player combinations with issues in integrity
As of 6/7/2016, I believe that tables are correct with respect to what is on the source data
Source data has a number of confirmed inconsistencies
Decision made to trust game tables and use them to update errors in the totals for consistency
Alternative suggestion is to confirm with second website but the errors are too numerous and dispersed to be practical
	Additionally, the errors are small and the effort would greatly exceed the gains in accuracy
*/

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