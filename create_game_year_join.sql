drop table if exists NBA_GAME_YEAR_JOIN;

create table if not exists NBA_GAME_YEAR_JOIN as
select box_score_text as game_id,
	0 as year_literal,
    0 as month,
    0 as day,
    0 as year_final
from NBA_GAME_LIST
;

update NBA_GAME_YEAR_JOIN
set year_literal = convert(substr(game_id, 1, 4), unsigned integer),
	month = convert(substr(game_id, 5, 2), unsigned integer),
    day = convert(substr(game_id, 7, 2), unsigned integer)
where year_literal = 0
;

update NBA_GAME_YEAR_JOIN
set year_final = year_literal + case when month >= 8 then 1 else 0 end
where year_final = 0
;

select * from NBA_GAME_YEAR_JOIN;