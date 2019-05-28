#!/usr/bin/env ruby

# process a log file and 
# print the number of views for each path ordered by views descending
# print the number of unique visitors for each path ordered by unique views descending

require_relative './lib/log_parser'

unless ARGV[0] && File.exist?(ARGV[0])
  puts "usage: parser.rb <log_file>"
  exit
end

parser = LogParser.new ARGV[0]

# list of webpages with most page views ordered from most pages views to less page views
parser.visits.each do |visit|
  puts "#{visit.path} #{visit.views} visits"
end


# list of webpages ordered by unique page views descending
parser.unique_views.each do |visit|
  puts "#{visit.path} #{visit.unique} unique views"
end