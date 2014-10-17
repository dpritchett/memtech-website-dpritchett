#!/usr/bin/env ruby
# encoding: utf-8

require 'erb'

infile = "#{ENV["HOME"]}/public_html/space_used.txt"

lines = open(infile).readlines

user_lines = lines.select { |l| l =~ /\/home\// }

usernames = user_lines.map { |l| l.split.last.gsub(/(\/home\/|\/|public_html)/, "") }

def render(usernames)
  tpl = "
        <h1>Welcome to memtech.website!</h1>
        <pre>Memtech.website is the home of free retro homepages for Memphis area tech enthusiasts.  Ask ~dpritchett about getting your own account today!</pre>
        <ul>
    <% usernames.shuffle.each do |u| %>
            <li><a href='/~<%= u %>'><%= u %></a></li>
    <% end %>
    </ul>
    <% user = usernames.sample %>
    <h2>check out <a href='/~<%= user %>'><%= user %></a>'s page</h2>
    <iframe align='bottom' width='100%' height='100%' src='/~<%= user %>'>
  "
    ERB.new(tpl).result
end

  outfile = open("/var/www/html/index.html", 'w')

  outfile.write render(usernames)
  outfile.close

  puts "User index refreshed"
