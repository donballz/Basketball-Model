require 'test/unit'
require 'mysql'
require 'yaml'
require_relative 'gen_sql_strings.rb'
require_relative 'team_detail.rb'
require_relative 'get_all_team_detail.rb'
require_relative 'game_detail.rb'
require_relative 'CONSTANTS.rb'

# Tests to include. 
 
class BBModelTestSuite < Test::Unit::TestCase
	
	def col_count_test(table)
		# verifies column count and row counts are all the same
		expect = table['cols'].length
		table['data'].each { |row| return false unless row.length == expect }
		return true
	end
	
	def got_advanced?(bs_table)
		# verifies that each player is listed twice
		player_cnt = Hash.new(0)
		bs_table['data'].each { |row| player_cnt[row[0]] += 1 }
		player_cnt.each { |k, v| return false if v != 2 }
		return true
	end
	
	def test_basic
		con = Mysql.new SRVR, USER, PSWD
		assert_equal(Mysql, con.class, "sql server connect failure")
		tables = YAML.load_file(File.join(__dir__, 'atl_tables.yml'))
		assert_equal(Array, tables.class, "tables not loaded")
		assert_equal("CREATE TABLE IF NOT EXISTS NBA_ROSTER (TEAM VARCHAR(3), YEAR INT, NUMBER INT,PLAYER VARCHAR(255),POS VARCHAR(255),HEIGHT INT,WEIGHT INT,BIRTH_DATE VARCHAR(255),YEARS_EXPERIENCE INT,COLLEGE_NAME VARCHAR(255))", build_create_table_str(tables[0]), "table string failure")
		con.close if con 
	end
	
	def test_team
		con = Mysql.new SRVR, USER, PSWD
		page_raw = YAML.load_file(File.join(__dir__, 'atl_raw.txt'))
		assert_equal(String, page_raw.class, "ATL Raw not found")
		starts = get_start_pos(page_raw, CSTR, 0, page_raw.length)
		tables = get_tables(page_raw, starts)
		assert_equal(66844, starts[0], "starting position failed")
		assert_equal('Sacramento Kings', clean_string('<a href="/teams/SAC/2001.html">Sacramento Kings</a>'), "string clean failure")
		assert_equal('<a href="/boxscores/200010310ATL.html"Box Score</a', clean_string('<a href="/boxscores/200010310ATL.html">Box Score</a>'), "string clean Box Score exception failure")
		assert_equal('Current Roster', tables[1]['name'], "get tables function fail")
		assert_equal(["int", "varchar", "varchar", "int", "int", "varchar", "int", "varchar"], build_col_type_list(con, 'Roster'), "column type test")
		assert(col_count_test(tables[0]))
		assert(col_count_test(tables[1]))
		con.close if con
	end
	
	def test_bs
		page_raw = YAML.load_file(File.join(__dir__, 'boxscore_raw.txt'))
		assert_equal(String, page_raw.class, "Boxscore Raw not found")
		starts = get_start_pos(page_raw, BOXT, 0, page_raw.length)
		fix_bs_starts(page_raw, starts)
		assert_equal(22123, starts[0], "starting position failed")
		assert_equal(page_raw.length, starts[-1], "ending position failed")
		tables = get_tables(page_raw, starts)
		assert(got_advanced?(tables[0]))
		assert(got_advanced?(tables[1]))
	end 
	
	def test_pbp
		page_raw = YAML.load_file(File.join(__dir__, 'pbp_raw.txt'))
		assert_equal(String, page_raw.class, "Play-by-play Raw not found")
		starts = get_start_pos(page_raw, CSTR, 0, page_raw.length)
		assert_equal(26109, starts[0], "starting position failed")
		tables = get_pbp_tables(page_raw, starts)
		assert(tables.any?) # lazy
	end
	
	def test_pm
		page_raw = YAML.load_file(File.join(__dir__, 'plus_minus_raw.txt'))
		assert_equal(String, page_raw.class, "Plus-minus Raw not found")
		starts = get_start_pos(page_raw, '<div style="width:100', 0, page_raw.length)
		assert_equal(23160, starts[0], "starting position failed")
		assert_equal(56754, starts[1], "starting position failed")
		tables = get_pm_tables(page_raw, starts)
		assert(tables.any?) # lazy
	end
end