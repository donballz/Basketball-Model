select  x.year,
		x.player,
        x.fg,
        y.fg,
        case when x.fg = y.fg then 0 else 1 end as fg_er
from (
select  a.year, 
		a.player, 
        a.fg + b.fg as fg,
        a.fga + b.fga as fga,
        a.fg3 + b.fg3 as fg3,
        a.fg3a + b.fg3a as fg3a,
        a.ft + b.ft as ft,
        a.fta + b.fta as fta,
        a.orb + b.orb as orb,
        a.drb + b.drb as drb,
        a.ast + b.ast as ast,
        a.stl + b.stl as stl,
        a.blk + b.blk as blk,
        a.tov + b.tov as tov,
        a.pf + b.pf as pf,
        a.pts + b.pts as pts
FROM NBA_TOTALS a
left join NBA_PLAYOFFS_TOTALS b
on a.year = b.year
  and a.player = b.player
) x
left join (
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
from NBA_GAME_STATS_BASIC c
inner join NBA_GAME_YEAR_JOIN d
on c.game_id = d.game_id
group by d.year_final,
		c.player
) y
on x.year = y.year and x.player = y.player
;