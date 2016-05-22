require 'yaml'
require_relative 'game_detail.rb'

global = YAML.load_file(File.join(__dir__, 'CONSTANTS.yml'))
clean = YAML.load_file(File.join(global['yaml'], '200010310CHI.yml'))
dirty = YAML.load_file(File.join(global['yaml'], '200010310DAL.yml'))

puts clean