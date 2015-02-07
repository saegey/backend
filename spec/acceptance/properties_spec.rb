require "spec_helper"

describe Endpoints::Properties do
  include Committee::Test::Methods
  include Rack::Test::Methods

  def app
    Routes
  end

  def schema_path
    "./docs/schema.json"
  end

  describe 'GET /properties' do
    it 'returns correct status code and conforms to schema' do
      get '/properties'
      assert_equal 200, last_response.status
      assert_schema_conform
    end
  end

  describe 'POST /properties' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      post '/properties', MultiJson.encode({})
      assert_equal 201, last_response.status
      assert_schema_conform
    end
  end

  describe 'GET /properties/:id' do
    it 'returns correct status code and conforms to schema' do
      get "/properties/123"
      assert_equal 200, last_response.status
      assert_schema_conform
    end
  end

  describe 'PATCH /properties/:id' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      patch '/properties/123', MultiJson.encode({})
      assert_equal 200, last_response.status
      assert_schema_conform
    end
  end

  describe 'DELETE /properties/:id' do
    it 'returns correct status code and conforms to schema' do
      delete '/properties/123'
      assert_equal 200, last_response.status
      assert_schema_conform
    end
  end
end
