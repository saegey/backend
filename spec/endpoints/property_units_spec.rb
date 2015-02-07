require "spec_helper"

describe Endpoints::PropertyUnits do
  include Rack::Test::Methods

  describe "GET /property-units" do
    it "succeeds" do
      get "/property-units"
      assert_equal 200, last_response.status
    end
  end
end
