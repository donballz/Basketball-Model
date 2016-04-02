require 'open-uri'
require 'yaml'
require 'mysql'
require_relative 'StringFind.rb'
require_relative 'team_detail.rb'
require_relative 'gen_sql_strings.rb'
require_relative 'get_all_team_detail.rb'

# MUST BUILD:
# Test suite. 
# Tests to include. 
# 1. Connect to mysql successful.
# 2. Parse tables from yaml raw.
# 3. Columns, types, rows all have same number of rows.
# 4. Since raw is static, develop specific values to test.

# SCRATCH THAT
# Use this site instead: http://www.basketball-reference.com/leagues/NBA_2001_games.html

def clean_box_score(tables)
	# Gets relevant piece of the link to the game
	tables.each do |table|
		table['data'].each do |row|
			for i in 0...row.length
				datum = row[i]
				pos = datum.find('<a href="/boxscores/') if datum.class == String
				if pos != -1 and datum.class == String
					end_pos = datum.index('.', pos)
					datum = datum[pos...end_pos]
					row[i] = datum
				end
			end
		end
	end
end

def parse_game_links(year, search, path)
	# master function to call the others
	site = "http://www.basketball-reference.com/leagues/NBA_#{year}_games.html"
	page_raw = URI.parse(site).read
	table_starts = get_start_pos(page_raw, search, 0, page_raw.length)
	tables = get_tables(page_raw, table_starts)
	clean_box_score(tables)
	File.open(File.join(path, "zzGames_#{year}.yml"), 'w') do |f| 
		f.write tables.to_yaml
	end
	return tables
end

def get_all_links(cstr, path)
	# get all links for the games by scanning through the game pages
	for year in 2001..2016
		puts "Building #{year}"
		parse_game_links(year, cstr, path)
	end
end

def yaml_to_sql(con, path)
	# get yaml tables and upload to mysql
	#tables = YAML.load_file(File.join(path, "zzGames_2001.yml"))
	#tables.each { |table| puts build_create_table_str(table) }
	for year in 2001..2016
		puts "Uploading #{year}"
		tables = YAML.load_file(File.join(path, "zzGames_#{year}.yml"))
		write_to_sql(con, tables, 'DUM', year)
	end
end

begin
	global = YAML.load_file(File.join(__dir__, 'CONSTANTS.yml'))
	con = Mysql.new global['srvr'], global['user'], global['pswd']
	con.query("USE bball")
	
	#get_all_links(global['cstr'], global['yaml'])
	yaml_to_sql(con, global['yaml'])

rescue Mysql::Error => e
	puts e.errno
	puts e.error

ensure
	con.close if con
end