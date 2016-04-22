require 'bundler'
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/development.db"
)

$: << '.'

require 'app/controllers/application_controller'

Dir["app/models/*.rb"].each {|f| require f}
Dir["app/controllers/*.rb"].each {|f| require f}
