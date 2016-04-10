USE BBALL;
CREATE TABLE IF NOT EXISTS NBA_GAME_STATS_BASIC (
GAME_ID VARCHAR(12),
TEAM_STRING VARCHAR(255),
CUR_RECORD VARCHAR(25),
PLAYER VARCHAR(255),
MIN_PLAYED FLOAT,
FG INT,
FGA INT,
FG_PCT FLOAT,
FG3 INT,
FG3A INT,
FG3_PCT FLOAT,
FT INT,
FTA INT,
FT_PCT FLOAT,
REB_OFF INT,
REB_DEF INT,
REB_TOT INT,
ASSISTS INT,
STEALS INT,
BLOCKS INT,
TURNOVERS INT,
PERS_FOULS INT,
POINTS INT,
PLUS_MINUS INT);

CREATE TABLE IF NOT EXISTS NBA_GAME_STATS_ADV (
GAME_ID VARCHAR(12),
TEAM_STRING VARCHAR(255),
CUR_RECORD VARCHAR(25),
PLAYER VARCHAR(255),
MIN_PLAYED FLOAT,
TRUE_SHOOT_PCT FLOAT,
EFF_FG_PCT FLOAT,
FG3A_PER_FGA_PCT FLOAT,
FTA_PER_FGA_PCT FLOAT,
REB_OFF_PCT FLOAT,
REB_DEF_PCT FLOAT,
REB_TOT_PCT FLOAT,
ASSIST_PCT FLOAT,
STEAL_PCT FLOAT,
BLOCK_PCT FLOAT,
TOVER_PCT FLOAT,
USAGE_PCT FLOAT,
RATING_OFF FLOAT,
RATING_DEF FLOAT); 
