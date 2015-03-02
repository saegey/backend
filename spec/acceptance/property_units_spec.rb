require "spec_helper"

describe Endpoints::PropertyUnits do
  include Committee::Test::Methods
  include Rack::Test::Methods
  include RSpec::Matchers
  include Requests::JsonHelpers

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
      expect(json[0].property_id).to eq(@property.id)
      expect(json[0].pin_code).to eq('1234')
    end

    it 'returns unauthorized status code' do
      get "/v1/properties/#{@property.id}/units"
      expect(last_response.status).to eq(401)
    end
  end


  describe 'POST /v1/properties/id/units' do
    before do
      @data = { property_id: @property.id, pin_code: '1234'}
    end

    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      post "/v1/properties/#{@property.id}/units", MultiJson.encode(@data), auth

      expect(last_response.status).to eq(201)
      expect(json.property_id).to eq(@data[:property_id])
      expect(json.pin_code).to be_a(String)
      expect(json.pin_code.to_i).to be_a(Integer)
    end

    it 'returns unauthorized status code' do
      post "/v1/properties/#{@property.id}/units", MultiJson.encode(@data)
      expect(last_response.status).to eq(401)
    end
  end


  describe "GET /properties/:property_id/units/:id" do
    it 'returns correct status code and conforms to schema' do
      get "/v1/properties/#{@property.id}/units/#{@property_unit.id}", {}, auth
      expect(last_response.status).to eq(200)
      # expect(last_response).to match_response_schema("property_unit")
    end

    it 'returns unauthorized status code' do
      get "/v1/properties/#{@property.id}/units/#{@property_unit.id}"
      expect(last_response.status).to eq(401)
    end
  end

  describe 'PATCH /properties/:property_id/units/:id' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      patch "/v1/properties/#{@property.id}/units/#{@property_unit.id}", MultiJson.encode({pin_code: "12345"}), auth
      expect(last_response.status).to eq(201)
      # expect(last_response).to match_response_schema("property_unit")
    end
  end

  describe 'DELETE /properties/:property_id/units/:id' do
    it 'returns correct status code and conforms to schema' do
      delete "/v1/properties/#{@property.id}/units/#{@property_unit.id}", {}, auth
      expect(last_response.status).to eq(200)
      # expect(last_response).to match_response_schema("property_unit")
    end
  end
end
