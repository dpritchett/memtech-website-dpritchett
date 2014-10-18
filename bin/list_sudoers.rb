#!/usr/bin/env ruby 

require 'json'
require 'date'

sudoers = `members sudo`.split

outfile = File.join(ENV["HOME"], 'public_html', 'data', 'sudoers.json')

output = {
  sudoers: sudoers,
  lastUpdated: DateTime.now,
}

open(outfile, 'w') { |f| f.puts JSON.dump(output) }
