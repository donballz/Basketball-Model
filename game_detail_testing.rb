require 'yaml'
require_relative 'game_detail.rb'
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
def parse_pm_test(game, site, search, path)
	# get plus minus. complete.
	page_raw = open_url("#{site}boxscores/plus-minus/#{game}.html")
	puts "page size: #{page_raw.length}"
	table_starts = get_start_pos(page_raw, search, 0, page_raw.length)
	puts "table starts: #{table_starts}"
	tables = get_pm_tables(page_raw, table_starts)
	puts "tables: #{tables}"
	#yaml_files(tables, path, "zpm_#{game}.yml")
	return 1 if tables.any?
	return 0
end


#site = global['site']
#search = global['boxt']
#pm = '<div style="width:100'
#pm_flag = parse_pm_test('200011010CLE', global['site'], pm, global['yaml'])
#tables = YAML.load_file(File.join(global['yaml'], 'zbs_200504170MIA.yml'))
#puts tables

#page_raw = open_url("http://www.basketball-reference.com/boxscores/plus-minus/200203070SEA.html")
#yaml_files(page_raw, __dir__, 'plus_minus_raw.txt')
#puts page_raw

page_raw = YAML.load_file(File.join(__dir__, 'boxscore_raw.txt'))
starts = get_start_pos(page_raw, global['boxt'], 0, page_raw.length)
fix_bs_starts(page_raw, starts)
tables = get_tables(page_raw, starts)
puts tables
#[0]['cols'].length
#tables[0]['data'].each { |row| puts row.length }
