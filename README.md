# Basketball-Model

Step 1 In dev: crawl Basketball Reference and get data for modeling. 

Step 2 ?

Step 3 PROFIT!!



file list:

CONSTANTS.rb - creates CONSTANTS.yml with needed global constants

CONSTANTS.yml - created from CONSTANTS.rb. Stores constants

README.md - this file with documentation

StringFind.rb - Extends the String base class with a few helper functions to simplify code

active_teams.sql - create table NBA_ACTIVE_TEAMS from NBA_TEAMS where defunct = 'N'

atl_raw.txt - text of ATL 2016 website saved for testing purposes

atl_tables.yml - parsed data of the test page saved for testing

get_teams.rb - creates table NBA_TEAMS from http://www.basketball-reference.com/teams/

			 - get_teams was the first file written and has significant learning curve

mysql_connect_test.rb - used to learn the ruby connection to mysql

team_detail_testing.rb - used in the build phase of team_detail.rb

team_detail.rb - parses a page of single team for a single year into ruby Hash.



drop_gen_tables.sql - drops all gen tables to restart during testing

dump_raw.rb - creates files like atl_raw.txt

GEN_TABLE_LIST.csv - List of team tables scraped from source

gen_sql_strings.rb - creates strings for create gen table queries

gen_table_build_test.sql - counts rows per table

get_all_team_detail.rb - parses all the data; then uploads to sql

atl_raw15.txt - text of ATL 2015 website saved for testing purposes, 15 tables differ from 16

create_gen_tables.sql - builds empty gen tables. stable platform makes uploading easier

create_yaml_bridge.sql - workaround for changing franchise abbrevs on source

boxscore_raw.txt - text of game boxscore website saved for testing

create_game_list.sql - builds master game list from regular season and playoffs scrapes. 

			- has flags to track completed game scrapes
			
create_height_fix_tbl.sql - creates shell to fix mis-scraped heights

game_detail_inventory.rb - looks at all the saved yaml files and updates the game list appropriately

			 - very simple test, does not find all errors in scrape.
			 
			 - flags are updated at point of scrape now, this code is a one-off
			 
game_detail_testing.rb - testing code for get_all_game_detail.rb

gen_game_sql_strings.sql - creates regular season and playoffs table shells for uploading lists of scraped games

gen_height_fix.rb - re-scrape of team tables to get heights in inches
			
			- should add this logic to the team_detail.rb logic for subsequent years.
			
game_detail.rb - holds functions for scraping of game details.

			- game detail in three main parts, this parses all three:
			
			- boxscore - core data by player for the game, points, rebounds etc
			
			- play-by-play - shots taken made, rebounds, blocks with time
			
			- plus-minus - shows player time on the court with contribution

get_all_game_detail.rb - iterates over all games to pull the game detail into yaml files

get_game_links.rb - runs through list of games by year and gets the game ID used in the URL's

update_roster_height.sql - final step in the height fix which puts the scraped number onto the main table

test_suite.rb - a suite of tests which must pass to continue. should be made more robust