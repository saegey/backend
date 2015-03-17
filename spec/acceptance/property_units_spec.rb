require "spec_helper"

describe Endpoints::PropertyUnits do
  def app
    Routes
  end

  def schema_path
    "./docs/schema.json"
  end

  before do
    @user = User.first
    @property = @user.account.properties[1]
    @property_unit = @property.property_units[0]
  end


  describe "GET /property-units" do
    it 'returns correct status code and conforms to schema' do
      get "/property-units", {}, auth
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end

    it 'returns unauthorized status code' do
      get "/property-units"
      expect(last_response.status).to eq(401)
    end
  end


  describe 'POST /property-units/id/units' do
    before do
      @data = { property_id: @property.id, phone_number: "+12345678123" }
    end

    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      post "/property-units", MultiJson.encode(@data), auth
      expect(last_response.status).to eq(201)
      assert_schema_conform
    end

    it 'returns unauthorized status code' do
      post "/property-units", MultiJson.encode(@data)
      expect(last_response.status).to eq(401)
    end
  end


  describe "GET /property-units/:id" do
    it 'returns correct status code and conforms to schema' do
      get "/property-units/#{@property_unit.id}", {}, auth
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end

    it 'returns unauthorized status code' do
      get "/property-units/#{@property_unit.id}"
      expect(last_response.status).to eq(401)
    end
  end

  describe 'PATCH /property-units/:id' do
    before do
      @data = { phone_number: "+19876543987" }
    end

    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      patch "/property-units/#{@property_unit.id}", MultiJson.encode(@data), auth
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end

    it 'returns unauthorized status code' do
      get "/property-units/#{@property_unit.id}"
      expect(last_response.status).to eq(401)
    end
  end

  describe 'DELETE /properties/:property_id/units/:id' do
    it 'returns correct status code and conforms to schema' do
      delete "/property-units/#{@property_unit.id}", {}, auth
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end

    it 'returns unauthorized status code' do
      delete "/property-units/#{@property_unit.id}"
      expect(last_response.status).to eq(401)
    end
  end
end
