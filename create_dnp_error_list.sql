drop table NBA_GAME_DNP_ERR;

create table if not exists temp_table (
GAME_ID varchar(12),
TSOURCE varchar(5));
;
# home teams
insert into temp_table (GAME_ID, TSOURCE)
select a.BOX_SCORE_TEXT, 'h_reg'
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
  and (a.HOME_PTS != b.POINTS
    or b.POINTS is NULL)
;
# visitor teams
insert into temp_table (GAME_ID, TSOURCE)
select a.BOX_SCORE_TEXT, 'v_reg'
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
where a.BOX_SCORE_TEXT != ' '
  and (a.VISITOR_PTS != b.POINTS
    or b.POINTS is NULL)
;
# home playoffs
insert into temp_table (GAME_ID, TSOURCE)
select a.BOX_SCORE_TEXT, 'h_pla'
from NBA_PLAYOFFS a
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
  and (a.HOME_PTS != b.POINTS
    or b.POINTS is NULL)
;
# visitor playoffs
insert into temp_table (GAME_ID, TSOURCE)
select a.BOX_SCORE_TEXT, 'v_pla'
from NBA_PLAYOFFS a
left join (
	select game_id, 
			team_string, 
			sum(points) as points 
    from NBA_GAME_STATS_BASIC 
    group by game_id, 
			team_string) b
on a.BOX_SCORE_TEXT = b.game_id
  and a.VISITOR_TEAM_NAME = b.TEAM_STRING
where a.BOX_SCORE_TEXT != ' '
  and (a.VISITOR_PTS != b.POINTS
    or b.POINTS is NULL)
;

create table NBA_GAME_DNP_ERR as
select distinct game_id, tsource
from temp_table
;

drop table temp_table;

select tsource, count(GAME_ID) as cnt from NBA_GAME_DNP_ERR group by tsource;

select a.*
from NBA_GAME_STATS_BASIC a
inner join NBA_GAME_DNP_ERR b
on a.game_id = b.game_id
;