require 'yaml'
require_relative 'StringFind.rb'

tables = YAML.load_file(File.join('/Users/donald/Google Drive/Basketball Model/Basketball-Model/yaml_files/', 'atl_2015.yml'))

def print_table(table)
	puts ""
	puts table['name']
	puts "#{table['cols']}"
	puts "#{table['type']}"
	table['data'].each do |row|
		puts "#{row}"
	end
	puts ""
end

#print_table(tables[0])
#tables.each { |table| print_table(table) }

def clean_string(str)
	# Remove html tags such as <href>
	cleaned = ""
	include = true
	str.each do |char|
		if char == '<'
			include = false
		elsif char == '>'
			include = true
		end
		cleaned += char if include and char != '>'
	end
	return cleaned
end

#puts clean_string("<a href=\"/players/m/millspa01.html\">Paul Millsap</a>")
#puts clean_string("<a href=\"/friv/colleges.cgi?college=florida\">University of Florida</a>")
#puts clean_string("<span style=\"margin-bottom: -5px;\" class=\"margin_left flag16 us\"></span>")

def table_counts(tables)
	tables.each do |table|
		puts ""
		puts table['name']
		puts "column count = #{table['cols'].length}"
		puts "type count = #{table['type'].length}"
		i = 0
		table['data'].each do |row|
			puts "row #{i} = #{row.length}"
			i += 1
		end
		puts ""
	end
end

table_counts(tables)