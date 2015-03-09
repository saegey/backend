require "spec_helper"

describe Endpoints::Auth do
  before do
    @user = User.first
  end

  let :api_version do
    {'HTTP_ACCEPT' => 'application/vnd.fobless+json; version=1'}
  end

  describe 'GET /v1/auth/password' do
    it 'returns correct status code and conforms to schema' do
      data = {
        email: "john.does@gmail.com",
        password: "test123"
      }
      # request.headers['HTTP_ACCEPT'] = 'application/vnd.fobless+json; version=1'
      post "/v1/auth/password", MultiJson.encode(data), api_version

      expect(last_response.status).to eq(200)
      expect(json.first_name).to eq('John')
      expect(json.last_name).to eq('Does')
      expect(json.email).to eq('john.does@gmail.com')
      expect(json.id).to be_a(Fixnum)
      expect(json.account.id).to be_a(Fixnum)
      expect(json.account.properties[0]["id"]).to be_a(Fixnum)
      expect(json.account.properties[0]["name"]).to eq("test property")
    end

    it 'returns correct status code for invalid attempt' do
      data = {
        email: "test@test.com",
        password: "wrong_password"
      }
      post "/v1/auth/password", MultiJson.encode(data), api_version
      expect(last_response.status).to eq(401)
    end
  end

  describe 'GET /v1/auth/github' do
    it 'returns correct status code and response' do
      get "/v1/auth/github", {}, api_version
      expect(last_response.status).to eq(302)
      expect(last_response.body).to eq(
        "Redirecting to http://example.org/v1/auth/github/callback..."
      )
    end
  end

  describe 'GET /v1/auth/twitter' do
    it 'returns correct status code and response' do
      get "/v1/auth/twitter", {}, api_version
      expect(last_response.status).to eq(302)
      expect(last_response.body).to eq(
        "Redirecting to http://example.org/v1/auth/twitter/callback..."
      )
    end
  end

  describe 'GET /v1/auth/github/callback' do
    it 'returns correct status code and response' do
      get "/v1/auth/github/callback", {}, api_version
      expect(last_response.status).to eq(200)
      expect(json.provider_id).to eq("12345")
      expect(json.provider).to eq("github")
      expect(json.created_at).to_not be_nil
      expect(json.updated_at).to_not be_nil
      expect(json.account.id).to be_a(Fixnum)
    end
  end

  describe 'GET /v1/auth/twitter/callback' do
    it 'returns correct status code and response' do
      get "/v1/auth/twitter/callback", {}, api_version
      data = JSON.parse(last_response.body)
      expect(last_response.status).to eq(200)
      expect(json.provider_id).to eq("67890")
      expect(json.provider).to eq("twitter")
      expect(json.created_at).to_not be_nil
      expect(json.updated_at).to_not be_nil
      expect(json.account.id).to be_a(Fixnum)
    end
  end
end

