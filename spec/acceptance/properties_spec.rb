require "spec_helper"

describe Endpoints::Properties do
  def app
    Routes
  end

  def schema_path
    "./docs/schema.json"
  end

  before do
    @user = User.first
    @property = @user.account.properties.first
  end

  describe 'GET /properties' do
    it 'returns correct status code and conforms to schema' do
      get "/properties", {}, auth
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end

  describe 'POST /properties' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      json = MultiJson.encode({
        name: 'test property',
        account_id: @user.account_id,
        outbound_phone_numbers: ["+12065189761"]
      })
      post '/properties', json, auth
      expect(last_response.status).to eq(201)
      assert_schema_conform
    end
  end

  describe 'GET /properties/:id' do
    it 'returns correct status code and conforms to schema' do
      get "/properties/#{@property.id}", {}, auth
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end

  describe 'PATCH /properties/:id' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      data = MultiJson.encode({
        name: 'new name',
        outbound_phone_numbers: ["+12065189761"]
      })
      patch "/properties/#{@property.id}", data, auth
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end

  describe 'DELETE /properties/:id' do
    it 'returns correct status code and conforms to schema' do
      delete "/properties/#{@property.id}", {}, auth
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end
end
