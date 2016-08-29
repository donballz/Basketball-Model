delete from NBA_GAME_STATS_BASIC
where GAME_ID in (select game_id from NBA_GAME_DNP_ERR);

delete from NBA_GAME_STATS_ADV
where GAME_ID in (select game_id from NBA_GAME_DNP_ERR);

update NBA_GAME_LIST a
inner join NBA_GAME_DNP_ERR b 
on a.BOX_SCORE_TEXT = b.game_id
set BS_COMPLETE = 0
;

update NBA_GAME_LIST_UPLOAD a
inner join NBA_GAME_DNP_ERR b
on a.game_id = b.game_id
set BS_COMPLETE = 0
;