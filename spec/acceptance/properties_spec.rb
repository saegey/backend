require "spec_helper"

describe Endpoints::Properties do
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
  end

  describe 'GET /v1/properties' do
    it 'returns correct status code and conforms to schema' do
      get '/v1/properties', {}, auth
      expect(last_response.status).to eq(200)
      expect(last_response).to match_response_schema("properties")
    end
  end

  describe 'POST /v1/properties' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      data = {name: 'test name'}
      post "/v1/properties", MultiJson.encode(data), auth
      body = JSON.parse(last_response.body)

      expect(last_response.status).to eq(201)
      expect(last_response).to match_response_schema("property")
      expect(body["name"]).to eq('test name')
    end
  end

  describe 'GET /v1/properties/:id' do
    it 'returns correct status code and conforms to schema' do
      get "/v1/properties/#{@property.id}", nil, auth
      expect(last_response.status).to eq(200)
      expect(last_response).to match_response_schema("property")
    end
  end

  describe 'PATCH /v1/properties/:id' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      data = { name: "test" }
      patch "/v1/properties/#{@property.id}", MultiJson.encode(data), auth

      res = JSON.parse(last_response.body)

      expect(last_response.status).to eq(200)
      expect(last_response).to match_response_schema("property")
      expect(res["name"]).to eq("test")
    end
  end

  describe 'DELETE /v1/properties/:id' do
    it 'returns correct status code and conforms to schema' do
      delete "/v1/properties/#{@property.id}", nil, auth
      expect(last_response.status).to eq(200)
      expect(last_response).to match_response_schema("property")
      expect(Property.first(id: @property_id)).to be_nil
    end
  end
end
