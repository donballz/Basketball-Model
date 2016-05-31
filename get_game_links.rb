require 'yaml'
require 'mysql'
require_relative 'StringFind.rb'
require_relative 'team_detail.rb'
require_relative 'gen_sql_strings.rb'
require_relative 'get_all_team_detail.rb'
require_relative 'CONSTANTS.rb'

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

def parse_game_links(year, search)
	# master function to call the others
	site = "http://www.basketball-reference.com/leagues/NBA_#{year}_games.html"
	page_raw = open_url(site)
	table_starts = get_start_pos(page_raw, search, 0, page_raw.length)
	tables = get_tables(page_raw, table_starts)
	clean_box_score(tables)
	File.open(File.join(YAMP, "zzGames_#{year}.yml"), 'w') do |f| 
		f.write tables.to_yaml
	end
	return tables
end

def get_all_links
	# get all links for the games by scanning through the game pages
	for year in 2001..2016
		puts "Building #{year}"
		parse_game_links(year, CSTR)
	end
end

def yaml_to_sql(con, path)
	# get yaml tables and upload to mysql
	#tables = YAML.load_file(File.join(path, "zzGames_2001.yml"))
	#tables.each { |table| puts build_create_table_str(table) }
	for year in 2001..2016
		tables = YAML.load_file(File.join(YAMP, "zzGames_#{year}.yml"))
		write_to_sql(con, tables, 'DUM', year)
	end
end

begin
	con = Mysql.new SRVR, USER, PSWD
	con.query("USE #{SCMA}")
	
	#get_all_links()
	yaml_to_sql(con)

rescue Mysql::Error => e
	puts e.errno
	puts e.error

ensure
	con.close if con
end