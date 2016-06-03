/* Run this code after game tables are loaded */
use bball;
set sql_safe_updates = 0;

alter table NBA_GAME_STATS_BASIC
add (
	TEAM  	VARCHAR(3),
    GDATE 	DATE)
;

alter table NBA_GAME_STATS_ADV
add (
	TEAM  	VARCHAR(3),
    GDATE 	DATE)
;

alter table NBA_GAME_PBP
add (
	TEAM  	VARCHAR(3),
    GDATE 	DATE)
;

alter table NBA_GAME_PLUS_MINUS
add (
	TEAM  	VARCHAR(3),
    GDATE 	DATE)
;

update NBA_GAME_STATS_BASIC a
set team = (
	select b.abbrev
    from NBA_ACTIVE_TEAMS b
    where a.team_string = b.city || ' ' || b.mascot),
    gdate = date_format(substr(a.game_id, 1, 8), '%Y%m%d')
where team is null
  and exists (
	select b.abbrev
    from NBA_ACTIVE_TEAMS b
    where a.team_string = b.city || ' ' || b.mascot)
;
commit;