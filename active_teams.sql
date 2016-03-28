use bball;
create table active_teams as
select *
from teams
where defunct = 'N'
;