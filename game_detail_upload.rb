require 'yaml'

def bs_post(game, path)
	# post processing for boxscore game data. last row has totals; limited out
	tables = YAML.load_file(File.join(path, "zbs_#{game}.yml"))
	basic, advanced, tracker = [], [], []
	tables.each do |t|
		paren = t['name'].index('(')
		primer = [game, t['name'][0...paren-1], t['name'][paren..-1]]
		limit = t['data'][0].length + 3
		t['data'].each do |row|
			if tracker.include?(row[0])
				advanced.push(primer + row)
				advanced[-1] = advanced[-1][0...limit - 5]
			else
				tracker.push(row[0])
				basic.push(primer + row)
				basic[-1] = basic[-1][0...limit]
			end
		end
	end
	return basic, advanced
end

def pbp_post(game, path)
	# post processing for play-by-play data. 
	tables = YAML.load_file(File.join(path, "zpbp_#{game}.yml"))
	output = []
	quarter = 0
	tables[0]['data'].each do |row|
		if row.any?
			quarter = 1 if row[1].index('1st quarter') != nil
			quarter = 2 if row[1].index('2nd quarter') != nil
			quarter = 3 if row[1].index('3rd quarter') != nil
			quarter = 4 if row[1].index('4th quarter') != nil
			output.push([game, quarter] + row) if row.length == 6
		end
	end
	return output
end

def pm_first(tables)
	# splits mega row into multiple rows for easier final processing
	output, new_row = [], []
	tables[0]['data'].each do |row|
		row.each do |datum|
			unless datum[0] == "\n"
				unless ['0','1','2','3','4','5','6','7','8','9'].include?(datum[0])
					output.push(new_row) if new_row.length > 1
					new_row = [] 
				end
				new_row.push(datum)
			end
		end
	end
	return output
end

def pm_post(game, path)
	# post processing for plus-minus data. hold onto your butts.
	tables = YAML.load_file(File.join(path, "zpm_#{game}.yml"))
	pm_tab = pm_first(tables)
	away = pm_tab[0...pm_tab.length / 2]
	home = pm_tab[pm_tab.length / 2...-1]
	p away
	puts
	p home
end

global = YAML.load_file(File.join(__dir__, 'CONSTANTS.yml'))
basic, advanced = bs_post('200203070SEA', global['yaml'])
pbp =  pbp_post('200203070SEA', global['yaml'])
pm = pm_post('200203070SEA', global['yaml'])
#puts pm.length