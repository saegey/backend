require "spec_helper"

describe Endpoints::PropertyUnits do
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

    @property_unit = PropertyUnit.new
    @property_unit.property_id = @property.id
    @property_unit.account_id = @user.account_id
    @property_unit.phone_number = "+12345678123"
    @property_unit.save
  end

  describe "GET /v1/property/{property_id}/units/" do
    it "succeeds" do
      get "/v1/properties/#{@property.id}/units", {}, auth
      assert_equal 200, last_response.status
    end
  end
end
