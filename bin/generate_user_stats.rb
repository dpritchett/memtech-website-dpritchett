#!/usr/bin/env ruby

############################################################
# Dump some basic user stats into ~/public/html/data
# as a JSON file for use around the site
############################################################

require 'pry'
require 'date'
require 'json'

outfile = File.join ENV["HOME"], 'public_html', 'data', 'user_stats.json'

def users
  `ls /home -1`.split.map(&:strip)
end

def user_active?(user)
  x ||= open("/home/#{user}/public_html/index.html").read
  @skel ||= open("/etc/skel/public_html/index.html").read

  x != @skel
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

def webring_member?(user)
  `grep -R --include="*.html" webring_prev /home/#{user}/ | head -1 | wc -l`.strip == '1'
end

def user_stats(user)
  {
    'active' => user_active?(user),
    'name' => user,
    'timeSinceUpdate' => seconds_since_last_html_update(user),
    'spaceUsed'  => space_used_by(user),
    'webringMember'  => webring_member?(user),
  }
end

stats = { users: users.map{ |u| user_stats(u) } }
stats.merge!({ lastUpdated: DateTime.now })

open(outfile, 'w') { |f| f.puts JSON.dump(stats) }
