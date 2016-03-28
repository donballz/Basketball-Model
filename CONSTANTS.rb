require 'yaml'

GLOBAL = Hash.new
GLOBAL['path'] = '/Users/donald/Google Drive/Basketball Model/Basketball-Model/'
File.open(GLOBAL['path'] + "CONSTANTS.yml", 'w') { |f| f.write GLOBAL.to_yaml }