# Basketball-Model

In dev model to crawl Basketball Reference and get data for modeling. 
Step 2 ?
Step 3 = PROFIT!!

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