use bball;
#drop table NBA_ACTIVE_TEAMS;
create table NBA_ACTIVE_TEAMS as
select *
from nba_teams
where defunct = 'N'
;