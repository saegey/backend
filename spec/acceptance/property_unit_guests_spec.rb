require "spec_helper"

describe Endpoints::PropertyUnitGuests do
  # include Committee::Test::Methods
  # include Rack::Test::Methods

  def app
    Routes
  end

  def schema_path
    "./docs/schema.json"
  end

  let(:collection_uri) {
    "/property_unit_guests"
  }

  before do
    @user = User.first(first_name: "John")
    @property = @user.account.properties.last
    @property_unit = @property.property_units.first
    @guest = @property_unit.property_unit_guests.first
  end

  describe 'GET /property_unit_guests/:id' do
    it 'returns correct status code and conforms to schema' do
      get "collection_uri/#{@guest.id}", {}, auth
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end

=begin
  describe 'POST /property-unit-guests' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      post '/property-unit-guests', MultiJson.encode({})
      expect(last_response.status).to eq(201)
      assert_schema_conform
    end
  end
=end

  # describe 'GET /property-unit-guests/:id' do
  #   it 'returns correct status code and conforms to schema' do
  #     get "/property-unit-guests/#{@property_unit_guest.uuid}"
  #     expect(last_response.status).to eq(200)
  #     assert_schema_conform
  #   end
  # end

  # describe 'PATCH /property-unit-guests/:id' do
  #   it 'returns correct status code and conforms to schema' do
  #     header "Content-Type", "application/json"
  #     patch "/property-unit-guests/#{@property_unit_guest.uuid}", MultiJson.encode({})
  #     expect(last_response.status).to eq(200)
  #     assert_schema_conform
  #   end
  # end

  # describe 'DELETE /property-unit-guests/:id' do
  #   it 'returns correct status code and conforms to schema' do
  #     delete "/property-unit-guests/#{@property_unit_guest.uuid}"
  #     expect(last_response.status).to eq(200)
  #     assert_schema_conform
  #   end
  # end
end
