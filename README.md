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