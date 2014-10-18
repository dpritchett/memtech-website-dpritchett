#!/usr/bin/env ruby

require 'pry'
require 'date'
require 'json'

outfile = File.join ENV["HOME"], 'public_html', 'data', 'user_stats.json'

def users
  `ls /home -1`.split.map(&:strip)
end

def space_used_by(user)
  `du --max-depth=0 /home/#{user}`.split.first.to_i
end

def last_update_from(user)
  # find last html change
  cmd = "find /home/#{user}/" + ' -name \'*html\' -exec stat \{} --printf="%y\n" \; | sort -n -r | head -n 1'
  last_update = `#{cmd}`.strip

  DateTime.parse last_update
end

def seconds_since_datetime(dt)
  seconds_rational = (DateTime.now - dt) * 24 * 60 * 60
  seconds_rational.to_i
end

def seconds_since_last_html_update(user)
  seconds_since_datetime last_update_from(user)
end

def user_stats(user)
  {
    'name' => user,
    'timeSinceUpdate' => seconds_since_last_html_update(user),
    'spaceUsed'  => space_used_by(user),
  }
end

stats = { users: users.map{ |u| user_stats(u) } }

open(outfile, 'w') { |f| f.puts JSON.dump(stats) }
