require 'yaml'

GLOBAL = Hash.new
GLOBAL['path'] = '/Users/donald/Google Drive/Basketball Model/Basketball-Model/'
GLOBAL['yaml'] = '/Users/donald/Google Drive/Basketball Model/Basketball-Model/yaml_files/'
GLOBAL['site'] = 'http://www.basketball-reference.com/teams/'
GLOBAL['cstr'] = '<h2 data-mobile-header="" style="">'
GLOBAL['srvr'] = 'Donalds-Mini.attlocal.net'
GLOBAL['user'] = 'ruby'
GLOBAL['pswd'] = 'Rubycon1$'
File.open(File.join(__dir__, "CONSTANTS.yml"), 'w') { |f| f.write GLOBAL.to_yaml }