USE BBALL;
CREATE TABLE IF NOT EXISTS NBA_REGULAR_SEASON (
TEAM VARCHAR(3), 
YEAR INT, 
DATE_GAME VARCHAR(255),
GAME_START_TIME INT,
BOX_SCORE_TEXT VARCHAR(255),
VISITOR_TEAM_NAME VARCHAR(255),
VISITOR_PTS INT,
HOME_TEAM_NAME VARCHAR(255),
HOME_PTS INT,
OVERTIMES VARCHAR(255),
GAME_REMARKS VARCHAR(255))
;

CREATE TABLE IF NOT EXISTS NBA_PLAYOFFS (
TEAM VARCHAR(3), 
YEAR INT, 
DATE_GAME VARCHAR(255),
GAME_START_TIME INT,
BOX_SCORE_TEXT VARCHAR(255),
VISITOR_TEAM_NAME VARCHAR(255),
VISITOR_PTS INT,
HOME_TEAM_NAME VARCHAR(255),
HOME_PTS INT,
OVERTIMES VARCHAR(255),
GAME_REMARKS VARCHAR(255))
;