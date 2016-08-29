# Defunct flag fails for first Defunct team (Anderson)
# City names with spaces failed e.g. Los Angelos
#    Added some movement to get around it, got fewer failures 
#    but still requires some manual overrides
# Written before StringFind. Could be simplified with that

require 'open-uri'
require 'yaml'
require 'mysql'
require_relative 'CONSTANTS.rb'

team_raw = URI.parse('http://www.basketball-reference.com/teams/').read
#File.open(PATH + "team_raw.txt", 'w') { |f| f.write team_raw.to_yaml }
#team_raw = YAML.load_file(PATH + "team_raw.txt")

def mask(num)
	return -1 if num == nil
	return num
end

def min(str)
	one = str.index('partial_table')
	two = str.index('full_table')
	return two if one == nil	
	return one if two == nil
	return one if one < two
	return two
end

def get_data(str)
	data_row = []
	start = 1
	while start < mask(min(str)) do
		start = str.index('<td align="right" >')
		if start != nil and start < mask(min(str))
			finish = str.index('</td>', start)
			data_row.push(str[start + 19...finish].to_i)
		else
			return data_row
		end
		str = str[finish + 1..-1]
	end
	return data_row
end

teams = []
found = 1
while found != nil do
	team = {}
	found = team_raw.index('<a href="/teams/')
	if found != nil
		team['abbrev'] = team_raw[found + 16, 3].strip
		start = team_raw.index('>', found + 1)
		finish = team_raw.index(' ', start + 5)
		team['city'] = team_raw[start + 1...finish].strip
		start = finish
		finish = team_raw.index('<', start + 1)
		team['mascot'] = team_raw[start + 1...finish].strip
		teams.push(team)
		team['data'] = get_data(team_raw[finish + 1..-1])
		defunct = team_raw.index('Defunct')
		if defunct == nil
			team['defunct'] = 'Y'
		else
			team['defunct'] = 'N'
		end
		team_raw = team_raw[finish + 1..-1]
		
	end
end

#teams.each do |t|
#	puts "#{t['abbrev']} has #{t['data']}"
#end

begin
    con = Mysql.new SRVR, USER, PSWD
    	
	con.query("USE #{SCMA};")
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
			con.query("INSERT INTO NBA_TEAMS VALUES \
				('#{t['abbrev']}', '#{t['city']}', '#{t['mascot']}', '#{t['defunct']}'#{build_str})")
		end
    end

rescue Mysql::Error => e
    puts e.errno
    puts e.error
    
ensure
    con.close if con
end
