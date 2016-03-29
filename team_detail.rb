require 'open-uri'
require 'yaml'
require_relative 'StringFind.rb'

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
	mydata = []
	for i in 0..row_starts.length-2
		row = []
		pos = row_starts[i]
		until pos == -1 or pos > row_starts[i + 1]
			pos = str.find('<td align="', pos)
			pos = str.find('>', pos)
			end_pos = str.index('</td>', pos)
			unless pos == -1 or pos > row_starts[i + 1]
				datum = clean_string(str[pos...end_pos])
				if datum.find('.') != -1
					row.push(datum.to_f)
				elsif datum.to_i == 0
					row.push(datum)
				else
					row.push(datum.to_i)
				end
			end
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
		table['name'] = str[pos...end_pos]
		table['cols'] = []
		until pos == -1 or pos > starts[i + 1]
			pos = str.find('<th data-stat="', end_pos)
			end_pos = str.index('"', pos)
			table['cols'].push(str[pos...end_pos]) unless pos == -1 or pos > starts[i + 1]
		end
		table['data'] = get_data(str, starts[i], starts[i + 1])
		table['type'] = []
		unless table['data'][0] == nil
			table['data'][0].each do |datum|
				if datum.class == String
					table['type'].push('varchar(255)')
				elsif datum.class == Fixnum
					table['type'].push('int')
				elsif datum.class == Float
					table['type'].push('float')
				else
					table['type'].push('error')
				end
			end
		end
		tables.push(table)
	end
	return tables
end

def parse_team_data(team, year)
	# master function to call the others
	global = YAML.load_file(File.join(__dir__, 'CONSTANTS.yml'))
	page_raw = URI.parse("#{global['site']}#{team}/#{year}.html").read
	#table_starts = get_table_starts(page_raw)
	table_starts = get_start_pos(page_raw, global['cstr'], 0, page_raw.length)
	tables = get_tables(page_raw, table_starts)
	File.open(File.join(global['yaml'], "#{team}_#{year}.yml"), 'w') do |f| 
		f.write tables.to_yaml
	end
	return tables
end