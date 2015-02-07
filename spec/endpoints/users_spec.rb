require "spec_helper"

describe Endpoints::Users do
  include Rack::Test::Methods

  describe "GET /Users" do
    it "succeeds" do
      get "/Users"
      assert_equal 200, last_response.status
    end
  end
end
