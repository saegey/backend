require "spec_helper"

describe Endpoints::PropertyUnitGuests do
  def app
    Routes
  end

  def schema_path
    "./docs/schema.json"
  end

  before do
    @user = User.first(first_name: "John")
    @property = @user.account.properties.last
    @property_unit = @property.property_units.first
    @property_unit_guest = @property_unit.property_unit_guests.first
    @property_unit_guest.updated_at
    @property_unit_guest.save
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
      get "/property-unit-guests/#{@property_unit_guest.id}", {}, auth
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end

  describe 'PATCH /property-unit-guests/:id' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      data = MultiJson.encode({
        pin_code: '12345',
        email: 'guest@test1.com',
        phone_number: '+12223334444'
      })
      patch "/property-unit-guests/#{@property_unit_guest.id}", data, auth
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end

  describe 'DELETE /property-unit-guests/:id' do
    it 'returns correct status code and conforms to schema' do
      delete "/property-unit-guests/#{@property_unit_guest.id}", {}, auth
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end
end
