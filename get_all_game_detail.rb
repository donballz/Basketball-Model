require 'mysql'
require 'yaml'
require_relative 'team_detail.rb'
require_relative 'game_detail.rb'
require_relative 'CONSTANTS.rb'

# boxscore: http://www.basketball-reference.com/boxscores/200201050LAC.html
# play-by-play: http://www.basketball-reference.com/boxscores/pbp/200010310ATL.html
# plus-minus: http://www.basketball-reference.com/boxscores/plus-minus/200010310ATL.html

# basic and advanced stats in same "table" 
#   different number of columns
#   separated by team totals
# plus-minus and pbp tables need significant post processsing
# name of boxscore table should be in a column
# need custom upload function for box score data
# add these functions to test suite

def parse_bs(game, site, search, path)
	# get box scores. complete.
	page_raw = open_url("#{site}boxscores/#{game}.html")
	table_starts = get_start_pos(page_raw, search, 0, page_raw.length)
	fix_bs_starts(page_raw, table_starts)
	tables = get_tables(page_raw, table_starts)
	yaml_files(tables, path, "zbs_#{game}.yml")
	return 1 if tables.any?
	return 0
end

def parse_pbp(game, site, search, path)
	# get play-by-play. complete.
	page_raw = open_url("#{site}boxscores/pbp/#{game}.html")
	table_starts = get_start_pos(page_raw, search, 0, page_raw.length)
	tables = get_pbp_tables(page_raw, table_starts)
	yaml_files(tables, path, "zpbp_#{game}.yml")
	return 1 if tables.any?
	return 0
end

def parse_pm(game, site, search, path)
	# get plus minus. complete.
	page_raw = open_url("#{site}boxscores/plus-minus/#{game}.html")
	table_starts = get_start_pos(page_raw, search, 0, page_raw.length)
	tables = get_pm_tables(page_raw, table_starts)
	yaml_files(tables, path, "zpm_#{game}.yml")
	return 1 if tables.any?
	return 0
end

begin
	con = Mysql.new SRVR, USER, PSWD
	con.query("USE bball")
	rows = con.query("SELECT * FROM NBA_GAME_LIST")
	#pm = '<div style="width:1005px;' # original plus-minus search string failed on OT games
	pm = '<div style="width:100'
	site = SITE
	yaml = YAMP
	
	rows.each_hash do |row|
		game = row['BOX_SCORE_TEXT'] 
		bs_flag, pbp_flag, pm_flag = 1, 1, 1
		unless game == ''
			puts "processing #{game}"
			unless row['BS_COMPLETE'] == '1'
				bs_flag = parse_bs(game, site, BOXT, yaml)
				sleep(3)
			end
			
			unless row['PBP_COMPLETE'] == '1'
				pbp_flag = parse_pbp(game, site, CSTR, yaml)
				sleep(3)
			end
			
			unless row['PM_COMPLETE'] == '1'
				pm_flag = parse_pm(game, site, pm, yaml)
				sleep(3)
			end
			
			# push status back to server
			con.query("
				UPDATE NBA_GAME_LIST
				SET BS_COMPLETE = #{bs_flag},
					PBP_COMPLETE = #{pbp_flag},
					PM_COMPLETE = #{pm_flag}
				WHERE BOX_SCORE_TEXT = '#{game}'")
		end
	end

rescue Mysql::Error => e
	puts e.errno
	puts e.error

ensure
	con.close if con
end