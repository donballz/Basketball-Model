url = 'http://www.basketball-reference.com/boxscores/plus-minus/200011010CLE.html'
#require 'open-uri'
#puts URI.parse(url).read

require 'net/http'
require 'uri'
puts Net::HTTP.get(URI.parse(url))