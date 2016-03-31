require 'mysql'
require_relative 'team_detail.rb'

# to do list:
# write function to get NBA_TEAMS for master loop
# feels like I should only connect once and pass the con object around instead of 
#  connecting per function. significantly reduce the number of code lines

def build_column_list(table_name)
	# gets columns from information_schema and parses into string for insert query
	# not strictly necessary. response to misread error message
	begin
		con = Mysql.new 'Donalds-Mini.attlocal.net', 'ruby', 'Rubycon1$'
		rows = con.query "SELECT COLUMN_NAME AS COL FROM INFORMATION_SCHEMA.COLUMNS
 						WHERE TABLE_SCHEMA = 'BBALL' AND TABLE_NAME = 'NBA_#{table_name}';"

		build_str = ''
		rows.each_hash { |row| build_str += "#{row['COL']}," }
	
	rescue Mysql::Error => e
		puts e.errno
		puts e.error
	
	ensure
		con.close if con
	end
	return build_str = build_str[0...-1]
end

def write_to_sql(tables, team, year)
	# writes data from ruby object to mysql server
	begin
		con = Mysql.new 'Donalds-Mini.attlocal.net', 'ruby', 'Rubycon1$'
		con.query("USE bball;")
		tables.each do |t|
			unless ['Team Miscellaneous', 'Draft Rights'].include?(t['name'])
				if t['name'] == 'Current Roster'
					name = 'Roster'
				else
					name = t['name'].gsub(' ', '_')
				end
				col_list = build_column_list(name)
				build_str = ''
				t['data'].each do |row| 
					build_str += "('#{team}', #{year}"
					for i in 0...t['type'].length
						if t['type'][i] == 'varchar(255)'
							build_str += ", '#{row[i]}'" 
						else
							build_str += ", #{row[i].to_f}" 
						end
					end
					build_str += '),'
				end
				build_str = build_str[0...-1]
				puts "NBA_#{name}"
				con.query("INSERT INTO NBA_#{name} (#{col_list}) VALUES #{build_str}")
			end
		end

	rescue Mysql::Error => e
		puts e.errno
		puts e.error
	
	ensure
		con.close if con
	end
end

def run_all_data(con)
	# gets team and year from NBA_TEAMS and writes to yaml files
	con.query("USE bball")
	rows = con.query("SELECT ABBREV, YEAR_FROM, YEAR_TO FROM NBA_ACTIVE_TEAMS")
	rows.each_hash do |row|
		unless ['ATL','BOS','CHI','CHO'].include?(row['ABBREV'])
		i = row['YEAR_TO'].to_i
		while i >= row['YEAR_FROM'].to_i and i >= 2001
			tables = parse_team_data(row['ABBREV'], i)
			puts "#{row['ABBREV']} #{i} #{tables[0]['name']} #{tables[0]['type'].length}"
			i -= 1
		end
		end
	end
end

tables = YAML.load_file(File.join('/Users/donald/Google Drive/Basketball Model/Basketball-Model/yaml_files/', 'atl_2015.yml'))
#write_to_sql(tables, 'ATL', 2015)
begin
	con = Mysql.new 'Donalds-Mini.attlocal.net', 'ruby', 'Rubycon1$'
	run_all_data(con)

rescue Mysql::Error => e
	puts e.errno
	puts e.error

ensure
	con.close if con
end