# home teams
select sum( case when a.HOME_PTS = b.POINTS then 0 else 1 end ) as error_cnt
from NBA_REGULAR_SEASON a
left join (
	select game_id, 
			team_string, 
			sum(points) as points 
    from NBA_GAME_STATS_BASIC 
    group by game_id, 
			team_string) b
on a.BOX_SCORE_TEXT = b.game_id
  and a.HOME_TEAM_NAME = b.TEAM_STRING
where a.BOX_SCORE_TEXT != ' '
;