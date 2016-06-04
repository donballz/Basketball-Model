use bball_test;
drop table if exists player_totals_sum;
create table player_totals_sum as
select  a.year, 
		a.player, 
        sum(a.fg + ifnull(b.fg, 0)) as fg,
        sum(a.fga + ifnull(b.fga, 0)) as fga,
        sum(a.fg3 + ifnull(b.fg3, 0)) as fg3,
        sum(a.fg3a + ifnull(b.fg3a, 0)) as fg3a,
        sum(a.ft + ifnull(b.ft, 0)) as ft,
        sum(a.fta + ifnull(b.fta, 0)) as fta,
        sum(a.orb + ifnull(b.orb, 0)) as orb,
        sum(a.drb + ifnull(b.drb, 0)) as drb,
        sum(a.ast + ifnull(b.ast, 0)) as ast,
        sum(a.stl + ifnull(b.stl, 0)) as stl,
        sum(a.blk + ifnull(b.blk, 0)) as blk,
        sum(a.tov + ifnull(b.tov, 0)) as tov,
        sum(a.pf + ifnull(b.pf, 0)) as pf,
        sum(a.pts + ifnull(b.pts, 0)) as pts
FROM bball.NBA_TOTALS a
left join bball.NBA_PLAYOFFS_TOTALS b
on a.year = b.year
  and a.player = b.player
  and a.team = b.team
group by a.year, 
		a.player
;
# 20 min
create table player_gmstat_sum
select d.year_final as YEAR,
	   c.player,
       sum(c.fg) as fg,
       sum(c.fga) as fga,
       sum(c.fg3) as fg3,
       sum(c.fg3a) as fg3a,
       sum(c.ft) as ft,
       sum(c.fta) as fta,
       sum(c.reb_off) as orb,
       sum(c.reb_def) as drb,
       sum(c.assists) as ast,
       sum(c.steals) as stl,
       sum(c.blocks) as blk,
       sum(c.turnovers) as tov,
       sum(c.pers_fouls) as pf,
       sum(c.points) as pts
from bball.NBA_GAME_STATS_BASIC c
inner join bball.NBA_GAME_YEAR_JOIN d
on c.game_id = d.game_id
group by d.year_final,
		c.player
;

select  x.year,
		x.player,
        x.fg,
        y.fg,
        case when x.fg = y.fg then 0 else 1 end as fg_er
from player_totals_sum x
left join player_gmstat_sum y
on x.year = y.year and x.player = y.player
having fg_er = 1
;