# Query for use in game_detail_upload.rb
select scr.*,
	   upl.BS_COMPLETE as BS_UPLOAD,
       upl.PBP_COMPLETE as PBP_UPLOAD,
       upl.PM_COMPLETE as PM_UPLOAD
from NBA_GAME_LIST scr
inner join NBA_GAME_LIST_UPLOAD upl
on scr.BOX_SCORE_TEXT = upl.GAME_ID
where scr.BS_COMPLETE = 1 and scr.PBP_COMPLETE = 1 and scr.PM_COMPLETE = 1
  and (upl.BS_COMPLETE = 0 or upl.PBP_COMPLETE = 0 or upl.PM_COMPLETE = 0)
;