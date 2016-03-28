require 'open-uri'
require 'yaml'
require 'mysql'
require_relative 'StringFind.rb'

def _init_()
	# Get page to parse into data
	global = YAML.load_file(File.join(__dir__, 'CONSTANTS.yml'))	
	#return URI.parse('http://www.basketball-reference.com/teams/ATL/2016.html').read
	#File.open(path + "atl_raw.txt", 'w') { |f| f.write team_raw.to_yaml }
	return YAML.load_file(global['path'] + "atl_raw.txt")
end

def get_table_starts(str)
	# get all the table starting positions
	pos = 0
	table_starts = []
	while pos != -1 do
		pos = str.find('<h2 data-mobile-header="" style="">', pos)
		table_starts.push(pos) if pos != -1
	end
	table_starts.push(str.length - 1)
	return table_starts
end

def get_tables(str, starts)
	# build master array with tables from one page as ruby objects
	tables = []
	for i in 0..starts.length-2
		table = {}
		pos = starts[i]
		end_pos = str.index('</h2>', pos)
		puts "pos = #{pos}, end_pos = #{end_pos}"
		table['name'] = str[pos...end_pos]
		table['cols'] = []
		until pos == -1 or pos > starts[i + 1]
			pos = str.find('<th data-stat="', end_pos)
			end_pos = str.index('"', pos)
			table['cols'].push(str[pos...end_pos]) unless pos == -1
		end
		tables.push(table)
	end
	return tables
end

def main()
	page_raw = _init_()
	table_starts = get_table_starts(page_raw)
	puts get_tables(page_raw, table_starts)
end

main()