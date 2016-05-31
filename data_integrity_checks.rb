require 'mysql'
require 'yaml'
require_relative 'CONSTANTS.rb'
require_relative 'common_funcs.rb'

def sql_qry(fname, con)
	# runs single sql query saved in a .sql file
	qry_txt = read(fname, 'sql')
	return con.query("#{qry_txt}")
end

begin
	con = Mysql.new SRVR, USER, PSWD
	con.query("USE #{SCMA}")
	rows = sql_qry('game_upload_confirm', con)
	
	puts rows.num_rows

rescue Mysql::Error => e
	puts e.errno
	puts e.error

ensure
	con.close if con
end
