require "rspec"
require "pg"
require "movie"
require "actor"

DB = PG.connect({:dbname => 'movie_database_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE from movies *;")
    DB.exec("DELETE from actors *;")
  end
end
