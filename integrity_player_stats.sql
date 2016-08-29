/*
creates table from game_basic_stats and regular_season/playoffs and compares stat totals.
*/

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
FROM (
	select  p.year, 
			p.player, 
			sum(p.fg) as fg,
			sum(p.fga) as fga,
			sum(p.fg3) as fg3,
			sum(p.fg3a) as fg3a,
			sum(p.ft) as ft,
			sum(p.fta) as fta,
			sum(p.orb) as orb,
			sum(p.drb) as drb,
			sum(p.ast) as ast,
			sum(p.stl) as stl,
			sum(p.blk) as blk,
			sum(p.tov) as tov,
			sum(p.pf) as pf,
			sum(p.pts) as pts
	FROM bball.NBA_TOTALS p
	group by p.year, 
	p.player 
)a
left join (
	select  q.year, 
	q.player, 
			sum(q.fg) as fg,
			sum(q.fga) as fga,
			sum(q.fg3) as fg3,
			sum(q.fg3a) as fg3a,
			sum(q.ft) as ft,
			sum(q.fta) as fta,
			sum(q.orb) as orb,
			sum(q.drb) as drb,
			sum(q.ast) as ast,
			sum(q.stl) as stl,
			sum(q.blk) as blk,
			sum(q.tov) as tov,
			sum(q.pf) as pf,
			sum(q.pts) as pts
	FROM bball.NBA_PLAYOFFS_TOTALS q
	group by q.year, 
	q.player
) b
on a.year = b.year
  and a.player = b.player
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

select  
        sum( case when x.fg = y.fg then 0 else 1 end ) as fg_er,
		sum( case when x.fga = y.fga then 0 else 1 end ) as fga_er,
		sum( case when x.fg3 = y.fg3 then 0 else 1 end ) as fg3_er,
		sum( case when x.fg3a = y.fg3a then 0 else 1 end ) as fg3_er,
		sum( case when x.ft = y.ft then 0 else 1 end ) as ft_er,
		sum( case when x.fta = y.fta then 0 else 1 end ) as fta_er,
		sum( case when x.orb = y.orb then 0 else 1 end ) as orb_er,
		sum( case when x.drb = y.drb then 0 else 1 end ) as drb_er,
		sum( case when x.ast = y.ast then 0 else 1 end ) as ast_er,
		sum( case when x.stl = y.stl then 0 else 1 end ) as stl_er,
		sum( case when x.blk = y.blk then 0 else 1 end ) as blk_er,
		sum( case when x.tov = y.tov then 0 else 1 end ) as tov_er,
		sum( case when x.pf = y.pf then 0 else 1 end ) as pf_er,
		sum( case when x.pts = y.pts then 0 else 1 end ) as pts_er
from player_totals_sum x
left join player_gmstat_sum y
on x.year = y.year and x.player = y.player
where x.year != 2016
;