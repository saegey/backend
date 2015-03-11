source "https://rubygems.org"

gem "multi_json"
gem "oj"
gem "pg"
gem "pliny", git: "git@github.com:interagent/pliny.git"
gem "pry"
gem "pry-doc"
gem "puma", "~> 2.10"
gem "rack-ssl"
gem "rake"
gem "rollbar"
gem "sequel", "~> 4.16"
gem "sequel-paranoid"
gem "sequel_pg", "~> 1.6", require: "sequel"
gem "sinatra", "~> 1.4", require: "sinatra/base"
gem "sinatra-contrib", require: ["sinatra/namespace", "sinatra/reloader"]
gem "sinatra-router"
gem "sucker_punch"
gem 'redis-rack'
gem 'recursive-open-struct'
gem 'newrelic_rpm'

#auth
gem "omniauth"
gem "omniauth-oauth2"
gem "omniauth-github"
gem 'omniauth-twitter'
gem 'shield'

group :development, :test do
  gem "pry-byebug"
  gem 'guard'
  gem 'guard-rspec'
end

group :test do
  gem "committee"
  gem "database_cleaner"
  gem "dotenv"
  gem "rack-test"
  gem "rspec"
  gem 'json-schema'
  gem "codeclimate-test-reporter"
  gem 'mock_redis'
  gem 'prmd', git: "git@github.com:saegey/prmd.git"
end
