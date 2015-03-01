module Endpoints
  class Root < Base

    get "/v1/session" do
      halt(401) unless session[:user_id]
      encode session
    end

    private

    def serialize(data, structure = :default)
      Serializers::User.new(structure).serialize(data)
    end
  end
end
