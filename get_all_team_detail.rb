require 'mysql'
require_relative 'team_detail.rb'
require_relative 'CONSTANTS.rb'

def build_col_type_list(con, table_name)
	# gets column types from information_schema and parses into array for insert query
	rows = con.query "SELECT DATA_TYPE AS TYPE FROM INFORMATION_SCHEMA.COLUMNS
					WHERE TABLE_SCHEMA = '#{SCMA}' AND TABLE_NAME = 'NBA_#{table_name}';"
	
	col_types = []
	rows.each_hash { |row| col_types.push(row['TYPE']) }
	return col_types[2..-1]
end

def write_to_sql(con, tables, team, year)
	# writes data from ruby object to mysql server
	tables.each do |t|
		unless ['Team Miscellaneous', 'Draft Rights', 'Injury Report'].include?(t['name'])
			if t['name'] == 'Current Roster'
				name = 'Roster'
			else
				name = t['name'].gsub(' ', '_')
			end
			col_list = build_col_type_list(con, name)
			build_str = ''
			t['data'].each do |row| 
				build_str += "('#{team}', #{year}"
				row.delete_at(6) if name == 'Roster' and year == '2016'
				for i in 0...col_list.length
					if col_list[i] == 'varchar'
						build_str += ", '#{row[i].to_s.gsub("'", "`")}'" 
					else
						build_str += ", #{row[i].to_f}" 
					end
				end
				build_str += '),'
			end
			build_str = build_str[0...-1]
			puts "Building #{team} #{year} NBA_#{name}"
			#puts "INSERT INTO NBA_#{name} VALUES #{build_str}" if name == 'Roster' and year == '2016'
			con.query("INSERT INTO NBA_#{name} VALUES #{build_str}")
		end
	end
end

def run_all_data(con)
	# gets team and year from NBA_TEAMS and writes to yaml files
	# due to source site changing franchise abbreviation, there were some manual
	# 	adjustments needed to get all teams, all years
	# Run once and then it's not needed. Use yaml bridge to run the data
	rows = con.query("SELECT ABBREV, YEAR_FROM, YEAR_TO FROM NBA_ACTIVE_TEAMS")
	rows.each_hash do |row|
		i = row['YEAR_TO'].to_i
		while i >= row['YEAR_FROM'].to_i and i >= 2001
			tables = parse_team_data(row['ABBREV'], i)
			puts "#{row['ABBREV']} #{i} #{tables[0]['name']} #{tables[0]['type'].length}"
			i -= 1
		end
	end
end

def yaml_to_sql(con, path)
	# gets file names and teams to pass to sql via write_to_sql method
	rows = con.query("SELECT * FROM NBA_YAML_BRIDGE")
	rows.each_hash do |row|
		tables = YAML.load_file(File.join(path, row['FILE']))
		write_to_sql(con, tables, row['TEAM'], row['YEAR'])
	end
	#tables = YAML.load_file(File.join(path, 'atl_2006.yml'))
	#write_to_sql(con, tables, 'ATL', 2006)
end

begin
	# Main block commented out for downstream use
	con = Mysql.new SRVR, USER, PSWD
	con.query("USE #{SCMA}")
	
	#run_all_data(con)
	#yaml_to_sql(con, YAMP)

rescue Mysql::Error => e
	puts e.errno
	puts e.error

ensure
	con.close if con
end