require "spec_helper"

describe Endpoints::Accounts do
  before do
    @user = User.first
  end

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
