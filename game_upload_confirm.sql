select sum(done_flag) as done_flag
from (
SELECT *, 
	case when bs_complete = 0 or pbp_complete = 0 or pm_complete = 0
		then 1
        else 0
	end as done_flag
FROM NBA_GAME_LIST_UPLOAD) as A
;
	