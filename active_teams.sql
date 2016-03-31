use bball;
drop table if exists NBA_ACTIVE_TEAMS;
create table if not exists NBA_ACTIVE_TEAMS as
select *
from nba_teams
where defunct = 'N'
;

SELECT ABBREV, YEAR_FROM, YEAR_TO FROM NBA_ACTIVE_TEAMS;