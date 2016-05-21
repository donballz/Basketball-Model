require 'yaml'

GLOBAL = Hash.new
GLOBAL['path'] = '/Users/donald/Google Drive/Basketball Model/Basketball-Model/'
GLOBAL['yaml'] = '/Users/donald/Google Drive/Basketball Model/yaml_files/'
GLOBAL['site'] = 'http://www.basketball-reference.com/'
GLOBAL['cstr'] = '<h2 data-mobile-header="" style="">'
GLOBAL['boxt'] = '<h2 data-mobile-header="" style="color:white;background-color:rgb'
GLOBAL['srvr'] = 'Donalds-Mini.hsd1.in.comcast.net'
GLOBAL['user'] = 'ruby'
GLOBAL['pswd'] = 'Rubycon1$'
File.open(File.join(__dir__, "CONSTANTS.yml"), 'w') { |f| f.write GLOBAL.to_yaml }