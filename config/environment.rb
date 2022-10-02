require "activerecord"
Bundler.require
require_all 'app/models'

ActiveRecord::Base.establish_connection