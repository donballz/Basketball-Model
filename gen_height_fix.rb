require 'open-uri'
require 'yaml'
require 'mysql'
require_relative 'StringFind.rb'

#################################################################
# To do list:
# Need to alter main file and merge this logic in for go-forward
# ^ Subsequent years will need to be scraped. 
# ^ Long term goal
#################################################################

def get_start_pos(str, search, origin, limit)
	# get all the starting positions of like-data
	pos = origin
	starts = []
	until pos == -1 or pos > limit
		pos = str.find(search, pos)
		starts.push(pos) unless pos == -1 or pos > limit
	end
	starts.push(limit - 1)
	return starts
end

def clean_string(str)
	# Remove html tags such as <href>
	cleaned = ""
	include = true
	str.each do |char|
		if char == '<'
			include = false
		elsif char == '>'
			include = true
		end
		cleaned += char if include and char != '>'
	end
	return cleaned
end

def get_data(str, start, limit)
	# build array of arrays with data values
	row_starts = get_start_pos(str, '<tr  class="">', start, limit)
	if row_starts.length == 1
		row_starts = get_start_pos(str, '<tr  class="full_table"', start, limit)
	end
	mydata = []
	for i in 0..row_starts.length-2
		pos = row_starts[i]
		col_cnt = 0
		row = []
		until pos == -1 or pos > row_starts[i + 1]
			pos = str.find('<td align="', pos)
			h_pos = str.find('csk="', pos)
			pos = str.find('>', pos)
			end_pos = str.index('</td>', pos)
			unless h_pos == -1 or h_pos > row_starts[i + 1]
				# Custom exceptions for Roster table on column count
				row.push(str[pos...end_pos].to_i) if col_cnt == 0
				row.push(clean_string(str[pos...end_pos])) if col_cnt == 1 
				row.push(str[h_pos, 4].to_f) if col_cnt == 3
			end
			col_cnt += 1
		end
		mydata.push(row)
	end
	return mydata
end

def get_tables(str, starts)
	# build master array with tables from one page as ruby objects
	tables = []
	for i in 0..starts.length-2
		table = {}
		pos = starts[i]
		end_pos = str.index('</h2>', pos)
		table['name'] = str[pos...end_pos] unless end_pos == nil
		# Only processing height from Roster tables
		if ['Roster','Current Roster'].include?(table['name'])
			table['cols'] = []
			until pos == -1 or pos > starts[i + 1]
				pos = str.find('<th data-stat="', end_pos)
				end_pos = str.index('"', pos)
				# Only get columns height and number
				if ['height','number','player'].include?(str[pos...end_pos])
					table['cols'].push(str[pos...end_pos]) 
				end
			end
			table['data'] = get_data(str, starts[i], starts[i + 1])
			tables.push(table)
		end
	end
	return tables
end

def parse_height_data(team, year)
	# master function to call the others
	global = YAML.load_file(File.join(__dir__, 'CONSTANTS.yml'))
	page_raw = URI.parse("#{global['site']}#{team}/#{year}.html").read
	table_starts = get_start_pos(page_raw, global['cstr'], 0, page_raw.length)
	return get_tables(page_raw, table_starts)
end

def write_to_sql(con, tables, team, year)
	# writes data from ruby object to mysql server
	tables.each do |t|
		build_str = ''
		t['data'].each do |row| 
			build_str += "('#{team}', #{year}"
			for i in 0...3
				build_str += ", #{row[i]}" unless i == 1
				build_str += ", '#{row[i].to_s.gsub("'", "`")}'" if i == 1
			end
			build_str += '),'
		end
		build_str = build_str[0...-1]
		puts "Adding #{team} #{year}"
		#puts "INSERT INTO NBA_#{name} VALUES #{build_str}" if name == 'Roster' and year == '2016'
		con.query("INSERT INTO NBA_HEIGHT_FIX VALUES #{build_str}")
	end
end

def site_to_sql(con)
	# gets file names and teams to pass to sql via write_to_sql method
	rows = con.query("SELECT * FROM NBA_YAML_BRIDGE")
	rows.each_hash do |row|
		tables = parse_height_data(row['FILE_CD'], row['YEAR'])
		write_to_sql(con, tables, row['TEAM'], row['YEAR'])
	end
	#tables = parse_height_data('ATL', 2016)
	#write_to_sql(con, tables, 'ATL', 2016)
end

begin
	global = YAML.load_file(File.join(__dir__, 'CONSTANTS.yml'))
	con = Mysql.new global['srvr'], global['user'], global['pswd']
	con.query("USE bball")
	
	site_to_sql(con)

rescue Mysql::Error => e
	puts e.errno
	puts e.error

ensure
	con.close if con
end