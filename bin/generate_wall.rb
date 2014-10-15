#!/usr/bin/env ruby
# encoding: utf-8

require 'erb'
require 'date'
require 'pry'

outfile_name = "#{ENV["HOME"]}/public_html/memwall.html"
wall_lines   = `memwall`.split("\n")

def render_lines
  tpl = "
        <h1>Welcome to the memtech.website MemWall</h1>
        <pre>$ memwall hi</pre>
        <ul>
        <% wall_lines.each do |l| %>
          <% u, *rest = l.split('\t') %>
          <li><a href='/~<%= u %>'><%= u %></a>: <%= rest.join(' ') %></li>
        <% end %>
        </ul>
<div style=\"align: center; margin-top: 75px\"><%= DateTime.now %></div>"

  ERB.new(tpl).result
end

open(outfile_name, 'w') { |f| f.write render_lines }

puts "Wall refreshed"
