select done_flag, count(game_id) as cnt
from (
SELECT *, 
	case when bs_complete = 1 and pbp_complete = 1 and pm_complete = 1
		then 'Y'
        else 'N'
	end as done_flag
FROM NBA_GAME_LIST_UPLOAD) as A
group by done_flag
;
	