require "spec_helper"

describe Endpoints::PropertyUnitGuests do
  include Committee::Test::Methods
  include Rack::Test::Methods

  def app
    Routes
  end

  def schema_path
    "./docs/schema/schema.json"
  end

  before do
    @user = User.first(first_name: "John")
    @property = @user.account.properties.last
    @property_unit = @property.property_units.first
    @guest = @property_unit.property_unit_guests.first
    @guest.updated_at
    @guest.save
  end

  describe 'GET /property-unit-guests' do
    it 'returns correct status code and conforms to schema' do
      get "/property-unit-guests", {}, auth
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end

  describe 'POST /property-unit-guests' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      json = MultiJson.encode({
        account_id: @user.account_id,
        property_unit_id: @property_unit.id,
        pin_code: '54321'
      })
      post '/property-unit-guests', json, auth
      expect(last_response.status).to eq(201)
      assert_schema_conform
    end
  end

  describe 'GET /property-unit-guests/:id' do
    it 'returns correct status code and conforms to schema' do
      get "/property-unit-guests/#{@guest.id}", {}, auth
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end

  describe 'PATCH /property-unit-guests/:id' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      patch "/property-unit-guests/#{@guest.id}", MultiJson.encode({}), auth
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end

  # describe 'DELETE /property-unit-guests/:id' do
  #   it 'returns correct status code and conforms to schema' do
  #     delete "/property-unit-guests/#{@property_unit_guest.uuid}"
  #     expect(last_response.status).to eq(200)
  #     assert_schema_conform
  #   end
  # end
end
