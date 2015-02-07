require "spec_helper"

describe Endpoints::Properties do
  include Rack::Test::Methods

  describe "GET /properties" do
    it "succeeds" do
      get "/properties"
      assert_equal 200, last_response.status
    end
  end
end
