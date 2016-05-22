require 'yaml'
require_relative 'game_detail.rb'

global = YAML.load_file(File.join(__dir__, 'CONSTANTS.yml'))
#clean = YAML.load_file(File.join(global['yaml'], 'zpm_200010310CHI.yml'))
#dirty = YAML.load_file(File.join(global['yaml'], 'zpm_200010310DAL.yml'))

def pm_first(row)
	# splits mega row into multiple rows for easier final processing
	output, new_row = [], []
	row.each do |datum|
		unless datum[0] == "\n"
			unless ['0','1','2','3','4','5','6','7','8','9'].include?(datum[0])
				output.push(new_row) if new_row.length > 1
				new_row = [] 
			end
			new_row.push(datum)
		end
	end
	return output
end

def min_per(per)
	# number of minutes in a period
	return 12 if per < 5
	return 5
end

def pm_second(game, table)
	# converts once-processed pm file into final format for upload
	output, per_lens = [], []
	for ind in 0...table.length
		if ind == 0
			team = table[0][0]
			table[ind].each { |per| per_lens.push(per[0...per.find('/')].to_f) }
			per_lens = per_lens[1..-1]
		else
			tot_rem = 0
			per_lens.each { |d| tot_rem += d}
			per_lens_inst = per_lens.dup
			player = table[ind][0]
			player = player[0...player.index('(') - 1]
			for jnd in 1...table[ind].length
				slash = table[ind][jnd].index('/')
				dur = table[ind][jnd][0...slash].to_f
				pm = table[ind][jnd][slash + 1..-1]
				if pm == ""
					status = 'off'
				else
					status = 'on'
				end
				while dur > 0 and tot_rem > 0 do
					for per in 1..per_lens_inst.length
						per_rem = per_lens_inst[per - 1]
						if per_rem > 0
							if dur > per_rem
								time = per_rem / per_lens[per - 1] * min_per(per)
								dur -= per_rem
								tot_rem -= per_rem
								per_lens_inst[per - 1] = 0
							else
								time = dur / per_lens[per - 1] * min_per(per)
								per_lens_inst[per - 1] -= dur
								tot_rem -= dur
								dur = 0
							end
							output.push([game, team, player, per, time, status, pm])
							break
						end
					end
				end
			end
		end
	end
	return output
end

def pm_post(game, path)
	# post processing for plus-minus data. hold onto your butts.
	tables = YAML.load_file(File.join(path, "zpm_#{game}.yml"))
	away = pm_first(tables[0]['data'][0])
	home = pm_first(tables[0]['data'][1])
	return pm_second(game, away) + pm_second(game, home)
end

#clean = pm_post('200010310CHI', global['yaml'])
dirty = pm_post('200010310DAL', global['yaml'])

puts dirty