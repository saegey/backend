require "spec_helper"

describe Endpoints::Properties do
  include Rack::Test::Methods

  before do
    @user = User.new
    @user.first_name = 'adam'
    @user.last_name = 'saegebarth'
    @user.email = 'test@test.com'
    @user.password = 'test123'
    @user.save

    @property = Property.new
    @property.name = 'test property'
    @property.account_id = @user.account_id
    @property.save
  end

  describe "GET /properties" do
    it "succeeds" do
      get "/properties", {}, auth
      assert_equal 200, last_response.status
    end
  end
end
