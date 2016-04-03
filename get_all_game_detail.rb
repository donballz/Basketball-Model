require 'mysql'
require 'yaml'
require 'open-uri'
require_relative 'team_detail.rb'

# boxscore: http://www.basketball-reference.com/boxscores/200010310ATL.html
# play-by-play: http://www.basketball-reference.com/boxscores/pbp/200010310ATL.html
# plus-minus: http://www.basketball-reference.com/boxscores/plus-minus/200010310ATL.html

# basic and advanced stats in same "table" 
#   different number of columns
#   separated by team totals
# name of boxscore table should be in a column
# need custom upload function
# need custom plus-minus parser
# need custom pbp parser.
# FUCK.

class Mysql
	def each_game(sql_table)
		# allows box score strings for the links to be iterated
		rows = self.query("SELECT BOX_SCORE_TEXT FROM #{sql_table}")
		rows.each_hash do |row|
			yield row['BOX_SCORE_TEXT']
		end
	end
end

def get_pbp_data(str, start, limit)
	# build array of arrays with data values
	row_starts = get_start_pos(str, '<tr>', start, limit)
	mydata = []
	for i in 1..row_starts.length-2
		row = []
		pos = row_starts[i]
		col_cnt = 0
		until pos == -1 or pos > row_starts[i + 1]
			pos = str.find('<td', pos)
			pos = str.find('>', pos)
			end_pos = str.index('</td>', pos)
			unless pos == -1 or pos > row_starts[i + 1]
				datum = clean_string(str[pos...end_pos])
				if datum.to_i == 0 or col_cnt == 0
					if datum == '&nbsp;'
						row.push(nil) 
					else
						row.push(datum)
					end
				else
					row.push(datum.to_f)
				end
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
		table['data'] = get_pbp_data(str, starts[i], starts[i + 1])
		tables.push(table)
	end
	return tables
end

begin
	global = YAML.load_file(File.join(__dir__, 'CONSTANTS.yml'))
	con = Mysql.new global['srvr'], global['user'], global['pswd']
	con.query("USE bball")
	
	['NBA_REGULAR_SEASON'].each do |sqlt|
		con.each_game(sqlt) do |game| 
			unless game == ''
				# get box scores. complete.
				#page_raw = URI.parse("#{global['site']}boxscores/#{game}.html").read
				#table_starts = get_start_pos(page_raw, global['boxt'], 0, page_raw.length)
				#tables = get_tables(page_raw, table_starts)
				#sleep(3)
				
				# get play-by-play. in dev.
				page_raw = URI.parse("#{global['site']}boxscores/pbp/#{game}.html").read
				table_starts = get_start_pos(page_raw, global['cstr'], 0, page_raw.length)
				puts get_pbp_tables(page_raw, table_starts)
				#sleep(3)
				
				# get plus minus. not started.
				#page_raw = URI.parse("#{global['site']}boxscores/plus-minus/#{game}.html").read
				
				#sleep(3)
			end
			break
		end
	end
	#con.each_game('NBA_PLAYOFFS')

rescue Mysql::Error => e
	puts e.errno
	puts e.error

ensure
	con.close if con
end