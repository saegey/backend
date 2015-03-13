require "spec_helper"

describe Endpoints::Properties do
  before do
    @user = User.new
    @user.first_name = 'adam'
    @user.last_name = 'saegebarth'
    @user.email = 'test@test.com'
    @user.password = 'test123'
    @user.save

    @property = Property.new
    @property.name = 'test property'
    @property.outbound_phone_numbers = ["+12345678123", "+19876543212"]
    @property.account_id = @user.account_id
    @property.save
  end

  describe 'GET /properties' do
    it 'returns correct status code and conforms to schema' do
      get '/properties', {}, auth
      expect(last_response.status).to eq(200)
      expect(json[0].name).to eq('test property')
      expect(json[0].outbound_phone_numbers.length).to eq(2)
      expect(json[0].outbound_phone_numbers[0]).to eq("+12345678123")
      expect(json[0].outbound_phone_numbers[1]).to eq("+19876543212")
    end

    it 'returns unauthorized status code' do
      get '/properties'
      expect(last_response.status).to eq(401)
    end
  end

  describe 'POST /properties' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      data = {
        name: 'test name',
        outbound_phone_numbers: ["+12345678123", "+19876543212"]
      }

      post "/properties", MultiJson.encode(data), auth

      expect(last_response.status).to eq(201)
      expect(json.name).to eq('test name')
      expect(json.outbound_phone_numbers[0]).to eq("+12345678123")
      expect(json.outbound_phone_numbers[1]).to eq("+19876543212")
    end
  end

  describe 'GET /properties/:id' do
    it 'returns correct status code and conforms to schema' do
      get "/properties/#{@property.id}", nil, auth
      expect(last_response.status).to eq(200)
      expect(json.name).to eq('test property')
      expect(json.outbound_phone_numbers[0]).to eq("+12345678123")
      expect(json.outbound_phone_numbers[1]).to eq("+19876543212")
    end
  end

  describe 'PATCH /properties/:id' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      data = {
        name: 'test name new',
        outbound_phone_numbers: ["+19876543200"]
      }
      patch "/properties/#{@property.id}", MultiJson.encode(data), auth

      expect(last_response.status).to eq(200)
      expect(json.name).to eq("test name new")
      expect(json.outbound_phone_numbers[0]).to eq("+19876543200")
      expect(json.outbound_phone_numbers.length).to eq(1)
    end
  end

  describe 'DELETE /properties/:id' do
    it 'returns correct status code and conforms to schema' do
      delete "/properties/#{@property.id}", nil, auth
      expect(last_response.status).to eq(200)
      # expect(last_response).to match_response_schema("property")
      expect(Property.first(id: @property_id)).to be_nil
    end
  end
end
