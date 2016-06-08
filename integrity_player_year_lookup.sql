/*
for use with integrity_metric_checks and integrity_player_stats to pull details for errors found
*/

use bball_test;
set @player := 'Paul Pierce';
set @year := 2002;

select *
from bball.NBA_PLAYOFFS_TOTALS
where player = @player
  and year = @year
;

select *
from bball.NBA_TOTALS
where player = @player
  and year = @year
;

select a.*
from bball.NBA_GAME_STATS_BASIC a
inner join bball.NBA_GAME_YEAR_JOIN b
on a.game_id = b.game_id
where a.player = @player
  and b.year_final = @year
;
