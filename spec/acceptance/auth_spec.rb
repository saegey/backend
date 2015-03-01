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
end

