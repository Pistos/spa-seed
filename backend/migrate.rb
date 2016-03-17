require 'project-name/config'

c = $conf['db']
host = c['host']
database = c['database']
username = c['username']

puts `sequel -m migrations postgres://#{username}@#{host}/#{database}`
