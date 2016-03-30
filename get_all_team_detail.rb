require_relative 'team_detail.rb'

#parse_team_data('ATL', 2015)

def build_create_table_str(table)
	if table['name'] == "Current Roster"
		name = "ROSTER"
	else
		name = table['name'].upcase.gsub(' ', '_')
	end
	str = "CREATE TABLE IF NOT EXISTS NBA_#{name} (TEAM VARCHAR(3), YEAR INT, "
	for i in 0...table['type'].length
		str += "#{table['cols'][i].upcase} #{table['type'][i].upcase},"
	end
	return str[0...-1] + ")"
end

def write_to_sql(tables)
	begin
    con = Mysql.new 'Donalds-Mini.attlocal.net', 'ruby', 'Rubycon1$'
	con.query("USE bball;")
	tables.each do |t|
		build_str = ''
		con.query("CREATE TABLE IF NOT EXISTS NBA_TEAMS ( \
					ABBREV VARCHAR(3) PRIMARY KEY, \
					CITY VARCHAR(50), \
					MASCOT VARCHAR(50), \
					DEFUNCT VARCHAR(1), \
					YEAR_FROM INT, \
					YEAR_TO INT, \
					YEARS INT, \
					GAMES INT, \
					WINS INT, \
					LOSSES INT, \
					W_L_PCT INT, \
					PLAYOFFS INT, \
					DIVISION INT, \
					CONFERENCE INT, \
					CHAMPIONSHIPS INT)")
		teams.each do |t|
			if not(['">t', 'WAT'].include?(t['abbrev']))
				build_str = ''
				t['data'].each { |num| build_str += ", #{num}" }
				#puts "('#{t['abbrev']}', '#{t['city']}', '#{t['mascot']}'#{build_str})"
				con.query("INSERT INTO TEAMS VALUES \
					('#{t['abbrev']}', '#{t['city']}', '#{t['mascot']}', '#{t['defunct']}'#{build_str})")
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
tables.each do |t| 
	unless ['Team Miscellaneous', 'Draft Rights'].include?(t['name'])
		puts build_create_table_str(t)
		puts ""
	end
end