require 'test/unit'
require 'mysql'
require 'yaml'
require_relative 'gen_sql_strings.rb'
require_relative 'team_detail.rb'
require_relative 'get_all_team_detail.rb'

# Tests to include. 
# 3. Columns, types, rows all have same number of rows.
 
class BBModelTestSuite < Test::Unit::TestCase
	def tests
		global = YAML.load_file(File.join(__dir__, 'CONSTANTS.yml'))
		con = Mysql.new 'Donalds-Mini.attlocal.net', 'ruby', 'Rubycon1$'
		assert_equal(Mysql, con.class, "sql server connect failure")
		tables = YAML.load_file(File.join(__dir__, 'atl_tables.yml'))
		assert_equal(Array, tables.class, "tables not loaded")
		assert_equal("CREATE TABLE IF NOT EXISTS NBA_ROSTER (TEAM VARCHAR(3), YEAR INT, NUMBER INT,PLAYER VARCHAR(255),POS VARCHAR(255),HEIGHT INT,WEIGHT INT,BIRTH_DATE VARCHAR(255),YEARS_EXPERIENCE INT,COLLEGE_NAME VARCHAR(255))", build_create_table_str(tables[0]), "table string failure")
		page_raw = YAML.load_file(File.join(__dir__, 'atl_raw.txt'))
		assert_equal(String, page_raw.class, "Page Raw not found")
		starts = get_start_pos(page_raw, global['cstr'], 0, page_raw.length)
		assert_equal(66844, starts[0], "starting position failed")
		assert_equal('Sacramento Kings', clean_string('<a href="/teams/SAC/2001.html">Sacramento Kings</a>'), "string clean failure")
		assert_equal('<a href="/boxscores/200010310ATL.html"Box Score</a', clean_string('<a href="/boxscores/200010310ATL.html">Box Score</a>'), "string clean Box Score exception failure")
		assert_equal('Current Roster', get_tables(page_raw, starts)[1]['name'], "get tables function fail")
		assert_equal(["int", "varchar", "varchar", "int", "int", "varchar", "int", "varchar"], build_col_type_list(con, 'Roster'), "column type test")
		
	end 
end