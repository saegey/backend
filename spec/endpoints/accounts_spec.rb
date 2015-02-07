require "spec_helper"

describe Endpoints::Accounts do
  include Rack::Test::Methods

  describe "GET /accounts" do
    it "succeeds" do
      get "/accounts"
      assert_equal 200, last_response.status
    end
  end
end
