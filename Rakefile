task :environment do
  require_relative './config/environment'
end

namespace :migrate do
  task up: :environment do
    require_relative './db/migrations/01_create_db.rb'

    CreateDb.migrate(:up)
  end

  task down: :environment do
    require_relative './db/migrations/01_create_db.rb'

    CreateDb.migrate(:down)
  end
end