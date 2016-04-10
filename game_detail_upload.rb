require 'yaml'

def bs_post(game, path)
	# post processing for boxscore game data. last row has totals
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

global = YAML.load_file(File.join(__dir__, 'CONSTANTS.yml'))
basic, advanced = bs_post('200203070SEA', global['yaml'])
basic.each { |c| puts c.length }
puts
advanced.each { |c| puts c.length }