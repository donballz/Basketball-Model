require 'net/http'
require 'uri'
require 'yaml'
require 'mysql'
require_relative 'CONSTANTS.rb'

def write(obj, fname, path=PATH)
	# writes any object to supplied filename. naming conflict with rT class func
	File.open(path + "#{fname}.yml", 'w') { |f| f.write obj.to_yaml }
end

def read(fname, suffix='yml', path=PATH)
	# reads yaml file to object
	return YAML.load_file(path + "#{fname}.#{suffix}")
end

def get_page(url)
	# fetches webpage as flat string
	return Net::HTTP.get(URI.parse(url))
end

def annual_hash
	# return hash of blank hashes by year
	mh = {}
	(2001..2016).to_a.each { |y| mh[y] = Hash.new(0) }
	return mh
end

def sql_qry(fname, con)
	# runs single sql query saved in a .sql file
	qry_txt = read(fname, 'sql')
	return con.query("#{qry_txt}")
end