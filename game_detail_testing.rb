require_relative 'get_all_game_detail.rb'
# Should be no executable lines in the Main of game_inventory to run tests.

global = YAML.load_file(File.join(__dir__, 'CONSTANTS.yml'))
#con = Mysql.new global['srvr'], global['user'], global['pswd']
#con.query("USE bball")
"
i = 1
con.each_game('NBA_GAME_LIST') do |row|
	puts row
	i += 1
	break if i == 20
end
"
#con.close if con



#site = global['site']
#search = global['boxt']
bs_flag = parse_bs('200201050LAC', global['site'], global['boxt'], global['yaml'])
tables = YAML.load_file(File.join(global['yaml'], 'zbs_200201050LAC.yml'))
puts tables