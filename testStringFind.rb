require 'yaml'
require 'uri'
require_relative 'StringFind.rb'

path = '/Users/donald/Documents/Basketball Model/'
team_raw = YAML.load_file(path + "atl_raw.txt")

#team_raw = '<div class="stw" id="all_roster">
#<div class="table_heading">
#<h2 data-mobile-header="" style="">Current Roster</h2>
#<div class="table_heading_text"></div>
#</div>
#<div class="table_container p402_hide " id="div_roster">
#<table data-freeze="3" class="sortable  stats_table" id="roster">'

start = team_raw.find('<h2 data-mobile-header="" style="">')
finish = team_raw.index('</h2>', start)

puts "#{team_raw[start...finish]}end"