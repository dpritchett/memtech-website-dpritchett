#!/usr/bin/env ruby
# Encoding: utf-8

require 'erb'
require 'date'
require 'pry'

outfile_name = "#{ENV["HOME"]}/public_html/memwall.html"
wall_lines   = `memwall`.split("\n")
tpl          = open("/home/dpritchett/sites/wall.html.erb")

def render_lines(template)
  ERB.new(template).result
end

open(outfile_name, 'w') { |f| f.write render_lines(tpl) }

puts "Wall refreshed"
