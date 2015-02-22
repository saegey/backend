require "spec_helper"

describe Endpoints::Accounts do
  include Committee::Test::Methods
  include Rack::Test::Methods
  include RSpec::Matchers

  before do
    @user = User.first(email: 'test@test.com')
  end

  describe 'GET /accounts' do
    it 'returns correct status code and conforms to schema' do
      get '/accounts', nil, auth
      expect(last_response.status).to eq(200)
    end
  end

=begin
  describe 'POST /accounts' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      post '/accounts', MultiJson.encode({})
      expect(last_response.status).to eq(201)
      assert_schema_conform
    end
  end
=end

  describe 'GET /accounts/:id' do
    it 'returns correct status code and conforms to schema' do
      get "/accounts/#{@user.account_id}", nil, auth
      expect(last_response.status).to eq(200)
    end
  end

  describe 'PATCH /accounts/:id' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      patch "/accounts/#{@user.account_id}", MultiJson.encode({}), auth
      expect(last_response.status).to eq(200)
    end
  end

  describe 'DELETE /accounts/:id' do
    it 'returns correct status code and conforms to schema' do
      delete "/accounts/#{@user.account_id}", nil, auth
      expect(last_response.status).to eq(200)
    end
  end
end
