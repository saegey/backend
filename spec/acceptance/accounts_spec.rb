require "spec_helper"

describe Endpoints::Accounts do
  before do
    @user = User.first(email: 'john.does@gmail.com')
  end

  describe 'GET /v1/accounts/:id' do
    it 'returns correct status code and conforms to schema' do
      get "/v1/accounts/#{@user.account_id}", nil, auth
      expect(last_response.status).to eq(200)
    end
  end

  describe 'PATCH /v1/accounts/:id' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      patch "/v1/accounts/#{@user.account_id}", MultiJson.encode({}), auth
      expect(last_response.status).to eq(200)
    end
  end

  describe 'DELETE /v1/accounts/:id' do
    it 'returns correct status code and conforms to schema' do
      delete "/v1/accounts/#{@user.account_id}", nil, auth
      expect(last_response.status).to eq(200)
    end
  end
end
