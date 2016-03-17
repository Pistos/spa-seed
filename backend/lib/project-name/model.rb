require 'project-name/config'
require 'sequel'

db_conf = $conf['db']
$db = Sequel.connect("postgres://#{db_conf['username']}@#{db_conf['host']}/#{db_conf['database']}")

require 'project-name/model/user'
require 'project-name/model/thing'
