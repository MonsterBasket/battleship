require 'active_record'
require 'colorize'
require 'bundler/setup'
require 'rake'

Bundler.require
require_all './app/models'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: '../db/development.db'
)
ActiveRecord::Base.logger = nil