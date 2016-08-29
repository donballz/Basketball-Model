require 'yaml'

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
"
path = '/Users/donald/Google Drive/Basketball Model/Basketball-Model/yaml_files/'
tables = YAML.load_file(File.join(path, 'atl_2015.yml'))
tables.each do |t| 
	unless ['Team Miscellaneous', 'Draft Rights'].include?(t['name'])
		puts build_create_table_str(t)
		puts ""
	end
end
"