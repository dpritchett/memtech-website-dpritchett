#!/usr/bin/env ruby
# encoding: utf-8

require 'erb'

infile     = "/home/dpritchett/public_html/space_used.txt"
lines      = open(infile).readlines
user_lines = lines.select { |l| l =~ /\/home\// }
usernames  = user_lines.map { |l| l.split.last.gsub(/(\/home\/|\/|public_html)/, "") }

tpl        = open("/home/dpritchett/sites/homepage.html.erb").read

def render_home(tpl)
  ERB.new(tpl).result
end

outfile = open("/var/www/html/index.html", 'w')

outfile.write render_home(tpl)
outfile.close

puts "User index refreshed"
