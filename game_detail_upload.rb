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

global = YAML.load_file(File.join(__dir__, 'CONSTANTS.yml'))
basic, advanced = bs_post('200203070SEA', global['yaml'])
pbp =  pbp_post('200203070SEA', global['yaml'])
