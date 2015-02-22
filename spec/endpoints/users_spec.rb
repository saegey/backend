require "spec_helper"

describe Endpoints::Users do
  include Rack::Test::Methods

  before do
    @user = User.new
    @user.first_name = 'adam'
    @user.last_name = 'saegebarth'
    @user.email = 'test@test.com'
    @user.password = 'test123'
    @user.save
  end

  describe "GET /user" do
    it "succeeds" do
      get "/users", {}, auth
      assert_equal 200, last_response.status
    end
  end
end
