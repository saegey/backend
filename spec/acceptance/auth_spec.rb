require "spec_helper"

describe Endpoints::Auth do
  include Committee::Test::Methods
  include Rack::Test::Methods
  include RSpec::Matchers

  before do
    @user = User.first(email: 'test@test.com')
  end

  describe 'GET /v1/auth/password' do
    it 'returns correct status code and conforms to schema' do
      data = {
        email: "test@test.com",
        password: "test123"
      }
      post "/v1/auth/password", MultiJson.encode(data)
      expect(last_response.status).to eq(200)
    end

    it 'returns correct status code for invalid attempt' do
      data = {
        email: "test@test.com",
        password: "wrong_password"
      }
      post "/v1/auth/password", MultiJson.encode(data)
      expect(last_response.status).to eq(401)
    end
  end

  describe 'GET /v1/auth/github' do
    it 'returns correct status code and response' do
      get "/v1/auth/github"
      expect(last_response.status).to eq(302)
      expect(last_response.body).to eq(
        "Redirecting to http://example.org/v1/auth/github/callback..."
      )
    end
  end

  describe 'GET /v1/auth/twitter' do
    it 'returns correct status code and response' do
      get "/v1/auth/twitter"
      expect(last_response.status).to eq(302)
      expect(last_response.body).to eq(
        "Redirecting to http://example.org/v1/auth/twitter/callback..."
      )
    end
  end

  describe 'GET /v1/auth/github/callback' do
    it 'returns correct status code and response' do
      get "/v1/auth/github/callback"
      data = JSON.parse(last_response.body)
      expect(last_response.status).to eq(200)
      expect(data["provider_id"]).to eq("12345")
      expect(data["provider"]).to eq("github")
      expect(data["created_at"]).to_not be_nil
      expect(data["updated_at"]).to_not be_nil
      expect(data["account"]).to be_a(Hash)
      expect(data["account"]["id"]).to be_a(Fixnum)
    end
  end

  describe 'GET /v1/auth/twitter/callback' do
    it 'returns correct status code and response' do
      get "/v1/auth/twitter/callback"
      data = JSON.parse(last_response.body)
      expect(last_response.status).to eq(200)
      expect(data["provider_id"]).to eq("67890")
      expect(data["provider"]).to eq("twitter")
      expect(data["created_at"]).to_not be_nil
      expect(data["updated_at"]).to_not be_nil
      expect(data["account"]).to be_a(Hash)
      expect(data["account"]["id"]).to be_a(Fixnum)
    end
  end
end

