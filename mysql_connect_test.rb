require 'mysql'
require 'yaml'
require_relative 'CONSTANTS.rb'

#path = '/Users/donald/Documents/Basketball Model/Basketball-Model/'
#sql_str = YAML.load_file(path + "test.sql")

begin
    con = Mysql.new SRVR, USER, PSWD
    #result = con.query sql_str
	#puts result
	
	con.query("USE mydb;")
	#con.query("CREATE TABLE IF NOT EXISTS \
    #    Writers(Id INT PRIMARY KEY AUTO_INCREMENT, Name VARCHAR(25))")
    #con.query("INSERT INTO Writers(Name) VALUES('Jack London')")
    #con.query("INSERT INTO Writers(Name) VALUES('Honore de Balzac')")
    #con.query("INSERT INTO Writers(Name) VALUES('Lion Feuchtwanger')")
    #con.query("INSERT INTO Writers(Name) VALUES('Emile Zola')")
    #con.query("INSERT INTO Writers(Name) VALUES('Truman Capote')") */
    
    
    ### start one method of pulling each row ###
    #rs = con.query("SELECT * FROM Writers")
    #n_rows = rs.num_rows
    
    #puts "There are #{n_rows} rows in the result set"
    
    #n_rows.times do
    #    puts rs.fetch_row.join("\s")
    #end
    
    ### Better method of pulling each row, uses column names ###
    rs = con.query "SELECT * FROM Writers WHERE Id IN (1, 2, 3)"
    puts "We have #{rs.num_rows} row(s)"
    puts "We have #{con.field_count} col(s)"
    
    rs.each { |id, name| puts "#{id} #{name}" }
    
    #rs.each_hash do |row|
    #   puts row['Id'] + " " + row['Name']
    #end      
    
rescue Mysql::Error => e
    puts e.errno
    puts e.error
    
ensure
    con.close if con
end

