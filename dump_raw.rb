url = 'http://www.basketball-reference.com/boxscores/201310290IND.html'
#require 'open-uri'
#puts URI.parse(url).read

require 'net/http'
require 'uri'
puts Net::HTTP.get(URI.parse(url))