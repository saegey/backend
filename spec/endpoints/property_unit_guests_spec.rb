require "spec_helper"

describe Endpoints::PropertyUnitGuests do
  before do
    @user = User.first(first_name: "John")
    @property = @user.account.properties.last
    @property_unit = @property.property_units.first
    @guest = @property_unit.property_unit_guests.first
  end

  let(:collection_uri) {
    "/property-unit-guests"
  }
  let(:resource_uri) {
    "#{collection_uri}/#{@guest.id}"
  }

  describe "GET /property-unit-guests" do
    it "succeeds" do
      get "/property-unit-guests", {}, auth
      expect(last_response.status).to eq(200)
      expect(json[0].id).to eq(@guest.id)
      expect(json[0].pin_code).to eq(@guest.pin_code)
      expect(DateTime.parse(json[0].expires_at)).to be > DateTime.now
    end

    it "unauthorized" do
      get collection_uri, {}, {'HTTP_ACCEPT' => "application/vnd.fobless+json; version=1"}
      expect(last_response.status).to eq(401)
    end
  end

  describe "GET /property-unit-guests/:id" do
    it "succeeds" do
      get "/property-unit-guests/#{@guest.id}", {}, auth
      expect(last_response.status).to eq(200)
      expect(json.id).to eq(@guest.id)
      expect(json.pin_code).to eq(@guest.pin_code)
      expect(DateTime.parse(json.expires_at)).to be > DateTime.now
    end

    it "unauthorized" do
      get collection_uri, {}, {'HTTP_ACCEPT' => "application/vnd.fobless+json; version=1"}
      expect(last_response.status).to eq(401)
    end
  end
end
