module Endpoints
  class Root < Base

    get "/v1/session" do
      authorize!
      encode session
    end

    get '/v1/debug' do
      encode env.inspect
    end

    private

    def serialize(data, structure = :default)
      Serializers::User.new(structure).serialize(data)
    end
  end
end
