require 'mysql'
require 'yaml'
require 'open-uri'
require_relative 'team_detail.rb'

# boxscore: http://www.basketball-reference.com/boxscores/200010310ATL.html
# play-by-play: http://www.basketball-reference.com/boxscores/pbp/200010310ATL.html
# plus-minus: http://www.basketball-reference.com/boxscores/plus-minus/200010310ATL.html

# need a way to validate a game has been loaded in three parts. 
#   upload to sql server Y/N
#   important for the long term as we begin to load games from the active season
#   need to add a primary key 'game' to the REGULAR_SEASON and PLAYOFFS tables
# basic and advanced stats in same "table" 
#   different number of columns
#   separated by team totals
# plus-minus and pbp tables need significant post processsing
# name of boxscore table should be in a column
# need custom upload function for box score data
# add these functions to test suite

class Mysql
	def each_game(sql_table)
		# allows box score strings for the links to be iterated
		rows = self.query("SELECT BOX_SCORE_TEXT FROM #{sql_table}")
		rows.each_hash do |row|
			yield row['BOX_SCORE_TEXT']
		end
	end
end

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

begin
	global = YAML.load_file(File.join(__dir__, 'CONSTANTS.yml'))
	con = Mysql.new global['srvr'], global['user'], global['pswd']
	con.query("USE bball")
	
	['NBA_REGULAR_SEASON', 'NBA_PLAYOFFS'].each do |sqlt|
		con.each_game(sqlt) do |game| 
			unless game == ''
				puts "processing #{game}"
				# get box scores. complete.
				page_raw = URI.parse("#{global['site']}boxscores/#{game}.html").read
				table_starts = get_start_pos(page_raw, global['boxt'], 0, page_raw.length)
				tables = get_tables(page_raw, table_starts)
				yaml_files(tables, global['yaml'], "zbs_#{game}.yml")
				sleep(3)
				
				# get play-by-play. complete.
				page_raw = URI.parse("#{global['site']}boxscores/pbp/#{game}.html").read
				table_starts = get_start_pos(page_raw, global['cstr'], 0, page_raw.length)
				tables = get_pbp_tables(page_raw, table_starts)
				yaml_files(tables, global['yaml'], "zpbp_#{game}.yml")
				sleep(3)
				
				# get plus minus. complete.
				pm = '<div style="width:1005px;'
				page_raw = URI.parse("#{global['site']}boxscores/plus-minus/#{game}.html").read
				table_starts = get_start_pos(page_raw, pm, 0, page_raw.length)
				tables = get_pm_tables(page_raw, table_starts)
				yaml_files(tables, global['yaml'], "zpm_#{game}.yml")
				sleep(3)
			end
		end
	end

rescue Mysql::Error => e
	puts e.errno
	puts e.error

ensure
	con.close if con
end