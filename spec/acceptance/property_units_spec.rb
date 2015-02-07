require "spec_helper"

describe Endpoints::PropertyUnits do
  include Committee::Test::Methods
  include Rack::Test::Methods

  def app
    Routes
  end

  def schema_path
    "./docs/schema.json"
  end

  before do
    @property_unit = PropertyUnit.create

    # temporarily touch #updated_at until we can fix prmd
    @property_unit.updated_at
    @property_unit.save
  end

  describe 'GET /property-units' do
    it 'returns correct status code and conforms to schema' do
      get '/property-units'
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end

=begin
  describe 'POST /property-units' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      post '/property-units', MultiJson.encode({})
      expect(last_response.status).to eq(201)
      assert_schema_conform
    end
  end
=end

  describe 'GET /property-units/:id' do
    it 'returns correct status code and conforms to schema' do
      get "/property-units/#{@property_unit.uuid}"
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end

  describe 'PATCH /property-units/:id' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      patch "/property-units/#{@property_unit.uuid}", MultiJson.encode({})
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end

  describe 'DELETE /property-units/:id' do
    it 'returns correct status code and conforms to schema' do
      delete "/property-units/#{@property_unit.uuid}"
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end
end
