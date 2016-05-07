require 'project-name/config'

puts "Migrating database for env: #{$conf['env']}"

host = $conf['db/host']
database = $conf['db/database']
username = $conf['db/username']

puts `sequel -m migrations postgres://#{username}@#{host}/#{database}`
