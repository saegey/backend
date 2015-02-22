require "spec_helper"

describe Endpoints::Accounts do
  include Rack::Test::Methods

  before do
    @user = User.create({
      email: "test@test.com",
      first_name: "Bob",
      last_name: "Jones"
    })
    @user.updated_at
    @user.save
  end

  describe "GET /accounts" do
    it "succeeds" do
      get "/accounts", {}, auth
      assert_equal 200, last_response.status
    end
  end
end
