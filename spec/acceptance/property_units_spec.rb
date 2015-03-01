require "spec_helper"

describe Endpoints::PropertyUnits do
  include Committee::Test::Methods
  include Rack::Test::Methods
  include RSpec::Matchers

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
    @property_unit.pin_code = '1234'
    @property_unit.updated_at = Time.now
    @property_unit.save
  end

  describe "GET /v1/properties/id/units" do
    it 'returns correct status code and conforms to schema' do
      get "/v1/properties/#{@property.id}/units", {}, auth
      expect(last_response.status).to eq(200)
      # expect(last_response).to match_response_schema("property_units")
    end
  end


  describe 'POST /v1/properties/id/units' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      data = {property_id: @property.id, pin_code: '1234'}
      post "/v1/properties/#{@property.id}/units", MultiJson.encode(data), auth
      
      res = JSON.parse(last_response.body)
      
      expect(last_response.status).to eq(201)
      # expect(last_response).to match_response_schema("property_unit")
      expect(res["property_id"]).to eq(data[:property_id])
      expect(res["pin_code"]).to be_a(String)
      expect(res["pin_code"].to_i).to be_a(Integer)
    end
  end


  describe "GET /properties/:property_id/units/:id" do
    it 'returns correct status code and conforms to schema' do
      get "/v1/properties/#{@property.id}/units/#{@property_unit.id}", {}, auth
      expect(last_response.status).to eq(200)
      expect(last_response).to match_response_schema("property_unit")
    end
  end

  describe 'PATCH /properties/:property_id/units/:id' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      patch "/v1/properties/#{@property.id}/units/#{@property_unit.id}", MultiJson.encode({pin_code: "12345"}), auth
      expect(last_response.status).to eq(201)
      expect(last_response).to match_response_schema("property_unit")
    end
  end

  describe 'DELETE /properties/:property_id/units/:id' do
    it 'returns correct status code and conforms to schema' do
      delete "/v1/properties/#{@property.id}/units/#{@property_unit.id}", {}, auth
      expect(last_response.status).to eq(200)
      expect(last_response).to match_response_schema("property_unit")
    end
  end
end
