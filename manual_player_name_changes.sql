/* Changed in the team gen tables
  Glenn Robinson III => Glenn Robinson
  John Lucas III => John Lucas
  J.J. Barea => Jose Barea
*/

select *
from bball.NBA_GAME_STATS_BASIC
where player = 'Glenn Robinson'
;

use bball;
update NBA_ADVANCED set player = 'John Lucas' where player = 'John Lucas III';
update NBA_PER_100_POSS set player = 'John Lucas' where player = 'John Lucas III';
update NBA_PER_36_MINUTES set player = 'John Lucas' where player = 'John Lucas III';
update NBA_PER_GAME set player = 'John Lucas' where player = 'John Lucas III';
update NBA_PLAYOFFS_ADVANCED set player = 'John Lucas' where player = 'John Lucas III';
update NBA_PLAYOFFS_PER_100_POSS set player = 'John Lucas' where player = 'John Lucas III';
update NBA_PLAYOFFS_PER_36_MINUTES set player = 'John Lucas' where player = 'John Lucas III';
update NBA_PLAYOFFS_PER_GAME set player = 'John Lucas' where player = 'John Lucas III';
update NBA_PLAYOFFS_SHOOTING set player = 'John Lucas' where player = 'John Lucas III';
update NBA_PLAYOFFS_TOTALS set player = 'John Lucas' where player = 'John Lucas III';
update NBA_ROSTER set player = 'John Lucas' where player = 'John Lucas III';
update NBA_SALARIES set player = 'John Lucas' where player = 'John Lucas III';
update NBA_SHOOTING set player = 'John Lucas' where player = 'John Lucas III';
update NBA_TEAM_AND_OPPONENT_STATS set player = 'John Lucas' where player = 'John Lucas III';
update NBA_TOTALS set player = 'John Lucas' where player = 'John Lucas III';