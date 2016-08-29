require 'yaml'
require_relative 'team_detail.rb'

# boxscore: http://www.basketball-reference.com/boxscores/200201050LAC.html
# play-by-play: http://www.basketball-reference.com/boxscores/pbp/200010310ATL.html
# plus-minus: http://www.basketball-reference.com/boxscores/plus-minus/200010310ATL.html

def get_custom_data(str, row_starts, search, end_search, skip = 0)
	# build array of arrays with data values
	mydata = []
	for i in skip..row_starts.length-2
		row = []
		pos = row_starts[i]
		col_cnt = 0
		until pos == -1 or pos > row_starts[i + 1]
			pos = str.find(search, pos)
			if str[pos...str.find('>', pos)].find('width:') > -1
				inner_pos = str.find('width:', pos)
				ender_pos = str.index('px', inner_pos)
				datum = str[inner_pos...ender_pos] + '/'
			else
				datum = ''
			end
			pos = str.find('>', pos)
			end_pos = str.index(end_search, pos)
			unless pos == -1 or pos > row_starts[i + 1]
				datum += clean_string(str[pos...end_pos])
				until datum.find('&nbsp;') == -1
					datum.slice!('&nbsp;')
				end
				row.push(datum)
			end
			col_cnt += 1
		end
		mydata.push(row)
	end
	return mydata
end

def get_pbp_tables(str, starts)
	# build master array with tables from one page as ruby objects
	tables = []
	for i in 0..starts.length-2
		table = {}
		pos = starts[i]
		end_pos = str.index('</h2>', pos)
		table['name'] = str[pos...end_pos]
		row_starts = get_start_pos(str, '<tr>', starts[i], starts[i + 1])
		table['data'] = get_custom_data(str, row_starts, '<td', '</td>', 1)
		tables.push(table)
	end
	return tables
end

def get_pm_tables(str, starts)
	# build master array with tables from one page as ruby objects
	tables = []
	for i in 0..starts.length-2
		table = {}
		table['name'] = 'Plus-Minus'
		row_starts = get_start_pos(str, '<div>', starts[i], starts[i + 1])
		table['data'] = get_custom_data(str, row_starts, '<div class="', '</div>')
		tables.push(table)
	end
	return tables
end

def yaml_files(tables, path, file)
	# quick helper to send tables to yaml
	File.open(File.join(path, file), 'w') do |f| 
		f.write tables.to_yaml
	end
end

def fix_bs_starts(str, starts)
	# each table has a different header based on the color so this function corrects
	#   to the true beginning of the table after universal search string
	# Easiser to fix than altering main function and rewriting upstream code
	starts.map! { |s| str.find('>', s) }
	starts[-1] = str.length
end