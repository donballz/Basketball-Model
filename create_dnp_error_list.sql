drop table NBA_GAME_DNP_ERR;

create table if not exists temp_table (
GAME_ID varchar(12));
;
# home teams
insert into temp_table (GAME_ID)
select b.game_id
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
where a.HOME_PTS != b.POINTS
;
# visitor teams
insert into temp_table (GAME_ID)
select b.game_id
from NBA_REGULAR_SEASON a
left join (
	select game_id, 
			team_string, 
			sum(points) as points 
    from NBA_GAME_STATS_BASIC 
    group by game_id, 
			team_string) b
on a.BOX_SCORE_TEXT = b.game_id
  and a.VISITOR_TEAM_NAME = b.TEAM_STRING
where a.VISITOR_PTS != b.POINTS
;

create table NBA_GAME_DNP_ERR as
select distinct game_id
from temp_table
;

select count(GAME_ID) as cnt from NBA_GAME_DNP_ERR;
