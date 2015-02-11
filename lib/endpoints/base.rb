module Endpoints
  # The base class for all Sinatra-based endpoints. Use sparingly.
  class Base < Sinatra::Base
    register Pliny::Extensions::Instruments
    register Sinatra::Namespace

    helpers Pliny::Helpers::Encode
    helpers Pliny::Helpers::Params

    set :dump_errors, false
    set :raise_errors, true
    set :show_exceptions, false

    configure :development do
      register Sinatra::Reloader
      also_reload '../**/*.rb'
    end

    use Rack::Session::Redis

    use OmniAuth::Builder do
      provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
      # provider :identity, :fields => [:email], :model => User
      provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
    end

    not_found do
      content_type :json
      status 404
      "{}"
    end
  end
end
