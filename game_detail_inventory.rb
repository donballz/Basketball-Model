require 'yaml'
require_relative 'CONSTANTS.rb'

def file_status(tables)
	# status of game yaml files
	return 2 if tables[0] == 'zFNFz'   # file not found
	return 1 if tables.any?			   # scrape good
	return 0 						   # scrape fail
end

def try_load(game, type)
	# handles exception if game-file not present and returns false. otherwise returns true
	begin
		try = YAML.load_file(File.join(YAMP "z#{type}_#{game}.yml"))
	rescue
		try = ['zFNFz']
	end
	return try
end

def Main()
	begin
		con = Mysql.new SRVR, USER, PSWD
		con.query("USE #{SCMA}")
		rows = con.query("SELECT * FROM NBA_GAME_LIST")

		rows.each_hash do |row| 
			game = row['BOX_SCORE_TEXT']
			unless game == ''
				puts "processing #{game}"
				# get box scores. complete.
				tables = try_load(game, 'bs')
				bs_flag = file_status(tables)
			
				# get play-by-play. complete.
				tables = try_load(game, 'pbp')
				pbp_flag = file_status(tables)
			
				# get plus minus. complete.
				tables = try_load(game, 'pm')
				pm_flag = file_status(tables)
				
				# push to server
				con.query("
					UPDATE NBA_GAME_LIST
					SET BS_COMPLETE = #{bs_flag},
						PBP_COMPLETE = #{pbp_flag},
						PM_COMPLETE = #{pm_flag}
					WHERE BOX_SCORE_TEXT = '#{game}'")
			end
		end

	rescue Mysql::Error => e
		puts e.errno
		puts e.error

	ensure
		con.close if con
	end
end

Main()