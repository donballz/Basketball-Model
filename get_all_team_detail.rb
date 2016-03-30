require 'mysql'
require_relative 'team_detail.rb'

# to do list:
# need single quotes in build_str for varchar fields
# trailing comma per row?
# control for Current Roster = ROSTER
# write function to get NBA_TEAMS for master loop

#parse_team_data('ATL', 2015)

def write_to_sql(tables, team, year)
	begin
		con = Mysql.new 'Donalds-Mini.attlocal.net', 'ruby', 'Rubycon1$'
		con.query("USE bball;")
		tables.each do |t|
			unless ['Team Miscellaneous', 'Draft Rights'].include?(t['name'])
				build_str = ''
				tables.each do |t|
					build_str = ''
					t['data'].each do |row| 
						build_str += "('#{team}', #{year}"
						row.each { |num| build_str += ", #{num}" }
						build_str += '),'
					end
					build_str = build_str[0...-1]
					puts "INSERT INTO NBA_#{t['name']} VALUES (#{build_str})"
					con.query("INSERT INTO NBA_#{t['name']} VALUES (#{build_str})")
				end
			end
		end

	rescue Mysql::Error => e
		puts e.errno
		puts e.error
	
	ensure
		con.close if con
	end
end

tables = YAML.load_file(File.join('/Users/donald/Google Drive/Basketball Model/Basketball-Model/yaml_files/', 'atl_2015.yml'))
write_to_sql(tables, 'ATL', 2015)