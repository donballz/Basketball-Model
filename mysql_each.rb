require 'mysql'

class Mysql
	def each_game(sql_table)
		# allows box score strings for the links to be iterated
		rows = self.query("SELECT * FROM #{sql_table}")
		rows.each_hash do |row|
			yield row
		end
	end
end