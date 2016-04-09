require 'mysql'
require 'yaml'
require 'open-uri'
require_relative 'mysql_each.rb'
require_relative 'team_detail.rb'

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

def get_custom_data(str, row_starts, search, end_search, skip = 0)
	# build array of arrays with data values
	mydata = []
	for i in skip..row_starts.length-2
		row = []
		pos = row_starts[i]
		col_cnt = 0
		until pos == -1 or pos > row_starts[i + 1]
			pos = str.find(search, pos)
			if str[pos...str.find('>', pos)].find('width:') > -1
				inner_pos = str.find('width:', pos)
				ender_pos = str.index('px', inner_pos)
				datum = str[inner_pos...ender_pos] + '/'
			else
				datum = ''
			end
			pos = str.find('>', pos)
			end_pos = str.index(end_search, pos)
			unless pos == -1 or pos > row_starts[i + 1]
				datum += clean_string(str[pos...end_pos])
				until datum.find('&nbsp;') == -1
					datum.slice!('&nbsp;')
				end
				row.push(datum)
			end
			col_cnt += 1
		end
		mydata.push(row)
	end
	return mydata
end

def get_pbp_tables(str, starts)
	# build master array with tables from one page as ruby objects
	tables = []
	for i in 0..starts.length-2
		table = {}
		pos = starts[i]
		end_pos = str.index('</h2>', pos)
		table['name'] = str[pos...end_pos]
		row_starts = get_start_pos(str, '<tr>', starts[i], starts[i + 1])
		table['data'] = get_custom_data(str, row_starts, '<td', '</td>', 1)
		tables.push(table)
	end
	return tables
end

def get_pm_tables(str, starts)
	# build master array with tables from one page as ruby objects
	tables = []
	for i in 0..starts.length-2
		table = {}
		table['name'] = 'Plus-Minus'
		row_starts = get_start_pos(str, '<div>', starts[i], starts[i + 1])
		table['data'] = get_custom_data(str, row_starts, '<div class="', '</div>')
		tables.push(table)
	end
	return tables
end

def yaml_files(tables, path, file)
	# quick helper to send tables to yaml
	File.open(File.join(path, file), 'w') do |f| 
		f.write tables.to_yaml
	end
end

def fix_bs_starts(str, starts)
	# each table has a different header based on the color so this function corrects
	#   to the true beginning of the table after universal search string
	# Easiser to fix than altering main function and rewriting upstream code
	starts.map! { |s| str.find('>', s) }
	starts[-1] = str.length
end

def parse_bs(game, site, search, path)
	# get box scores. complete.
	page_raw = URI.parse("#{site}boxscores/#{game}.html").read
	table_starts = get_start_pos(page_raw, search, 0, page_raw.length)
	fix_bs_starts(page_raw, table_starts)
	tables = get_tables(page_raw, table_starts)
	yaml_files(tables, path, "zbs_#{game}.yml")
	return 1 if tables.any?
	return 0
end

def parse_pbp(game, site, search, path)
	# get play-by-play. complete.
	page_raw = URI.parse("#{site}boxscores/pbp/#{game}.html").read
	table_starts = get_start_pos(page_raw, search, 0, page_raw.length)
	tables = get_pbp_tables(page_raw, table_starts)
	yaml_files(tables, path, "zpbp_#{game}.yml")
	return 1 if tables.any?
	return 0
end

def parse_pm(game, site, search, path)
	# get plus minus. complete.
	page_raw = URI.parse("#{site}boxscores/plus-minus/#{game}.html").read
	table_starts = get_start_pos(page_raw, search, 0, page_raw.length)
	tables = get_pm_tables(page_raw, table_starts)
	yaml_files(tables, path, "zpm_#{game}.yml")
	return 1 if tables.any?
	return 0
end

begin
	global = YAML.load_file(File.join(__dir__, 'CONSTANTS.yml'))
	con = Mysql.new global['srvr'], global['user'], global['pswd']
	con.query("USE bball")
	#pm = '<div style="width:1005px;' # original plus-minus search string failed on OT games
	pm = '<div style="width:100'
	
	con.each_game('NBA_GAME_LIST') do |row|
		game = row['BOX_SCORE_TEXT'] 
		bs_flag, pbp_flag, pm_flag = 1, 1, 1
		unless game == ''
			puts "processing #{game}"
			unless row['BS_COMPLETE'] == '1'
				bs_flag = parse_bs(game, global['site'], global['boxt'], global['yaml'])
				sleep(3)
			end
			
			unless row['PBP_COMPLETE'] == '1'
				pbp_flag = parse_pbp(game, global['site'], global['cstr'], global['yaml'])
				sleep(3)
			end
			
			unless row['PM_COMPLETE'] == '1'
				pm_flag = parse_pm(game, global['site'], pm, global['yaml'])
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