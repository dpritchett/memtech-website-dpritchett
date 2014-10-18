#!/usr/bin/env ruby 

require 'json'
require 'pry'

sudoers = `members sudo`.split

outfile = File.join(ENV["HOME"], 'public_html', 'data', 'sudoers.json')

open(outfile, 'w') { |f| f.puts JSON.dump({ sudoers: sudoers}) }
