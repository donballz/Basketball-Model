url = 'http://www.basketball-reference.com/boxscores/200601250HOU.html'
#require 'open-uri'
#puts URI.parse(url).read

require 'net/http'
require 'uri'
puts Net::HTTP.get(URI.parse(url))