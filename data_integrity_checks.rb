require 'mysql'
require 'yaml'
require_relative 'CONSTANTS.rb'
require_relative 'common_funcs.rb'

def sql_qry(fname, con)
	# runs single sql query saved in a .sql file
	qry_txt = read(fname, 'sql')
	return con.query("#{qry_txt}")
end

def single_row_result(fname, result_field, con)
	# requires single-row query. returns value of designated field
	rows = sql_qry(fname, con)
	return nil if rows.num_rows != 1
	rows.each_hash { |r| return r[result_field].to_i }
end
