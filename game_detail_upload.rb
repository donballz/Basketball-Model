require 'yaml'
require 'mysql'
require_relative 'StringFind.rb'
require_relative 'CONSTANTS.rb'

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

def build_col_types(con, table_name)
	# gets column types from information_schema and parses into array for insert query
	# can't use get_all_team_detail version as that is custom, ignoring first two columns
	rows = con.query "SELECT DATA_TYPE AS TYPE FROM INFORMATION_SCHEMA.COLUMNS
					WHERE TABLE_SCHEMA = '#{SCMA}' AND TABLE_NAME = '#{table_name}';"
	
	col_types = []
	rows.each_hash { |row| col_types.push(row['TYPE']) }
	return col_types
end

def row_to_string(row, cols)
	# converts row to string for upload to mysql
	str = "("
	for i in 0...cols.length
		if cols[i] == 'varchar'
			if row[i] == '' or row[i] == nil
				str += "'NA',"
			else
				str += "'#{row[i].gsub("'", "`")}'," 
			end
		else
			if row[i] == '' or row[i] == nil
				str += "0,"
			else
				str += "#{row[i].to_f}," 
			end
		end
	end
	return str[0...-1] + ")"
end

def up_to_sql(con, tbl, sql)
	# uploads processed yaml file to given sql table
	cols = build_col_types(con, sql)
	tbl.each do |row|
		str = row_to_string(row, cols)
		con.query("INSERT INTO #{sql} VALUES #{str}")
	end
	return nil
end

begin
	con = Mysql.new SRVR, USER, PSWD
	con.query("USE #{SCMA}")
	rows = con.query("SELECT * FROM NBA_GAME_LIST")

	rows.each_hash do |row|
		game = row['BOX_SCORE_TEXT'] 
		upl = con.query("SELECT * FROM NBA_GAME_LIST_UPLOAD WHERE GAME_ID = '#{game}'")
		up_bs, up_pbp, up_pm = '', '', ''
		upl.each_hash do |u|
			up_bs = u['BS_COMPLETE']
			up_pbp = u['PBP_COMPLETE']
			up_pm = u['PM_COMPLETE']
		end
		puts "processing #{game}"
		if row['BS_COMPLETE'] == '1' and up_bs == '0'
			basic, advanced = bs_post(game, YAMP)
			up_to_sql(con, basic, 'NBA_GAME_STATS_BASIC')
			up_to_sql(con, advanced, 'NBA_GAME_STATS_ADV')
			con.query("UPDATE NBA_GAME_LIST_UPLOAD SET BS_COMPLETE = 1 WHERE GAME_ID = '#{game}'")
		end
		
		if row['PBP_COMPLETE'] == '1' and up_pbp == '0'
			pbp =  pbp_post(game, YAMP)
			up_to_sql(con, pbp, 'NBA_GAME_PBP')
			con.query("UPDATE NBA_GAME_LIST_UPLOAD SET PBP_COMPLETE = 1 WHERE GAME_ID = '#{game}'")
		end
		
		if row['PM_COMPLETE'] == '1' and up_pm == '0'
			pm = pm_post(game, YAMP)
			up_to_sql(con, pm, 'NBA_GAME_PLUS_MINUS')
			con.query("UPDATE NBA_GAME_LIST_UPLOAD SET PM_COMPLETE = 1 WHERE GAME_ID = '#{game}'")
		end
	end

rescue Mysql::Error => e
	puts e.errno
	puts e.error

ensure
	con.close if con
end