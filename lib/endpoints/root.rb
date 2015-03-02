module Endpoints
  class Root < Base

    get "/v1/session" do
      authorize!
      encode session
    end

    private

    def serialize(data, structure = :default)
      Serializers::User.new(structure).serialize(data)
    end
  end
end
