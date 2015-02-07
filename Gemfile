source "https://rubygems.org"
ruby "2.2.0"

gem "multi_json"
gem "oj"
gem "pg"
gem "pliny", "~> 0.5"
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

#auth
gem "omniauth"
gem "omniauth-oauth2"
gem "omniauth-github"
gem 'omniauth-twitter'
gem 'shield'
# gem 'omniauth-identity'

group :development, :test do
  gem "pry-byebug"
end

group :test do
  gem "committee"
  gem "database_cleaner"
  gem "dotenv"
  gem "rack-test"
  gem "rspec"
end
