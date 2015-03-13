require "spec_helper"

describe Endpoints::Accounts do
  def app
    Routes
  end

  def schema_path
    "./docs/schema.json"
  end

  before do
    @account = Account.first
    @user = @account.users.first
  end

  describe 'GET /accounts/:id' do
    it 'returns correct status code and conforms to schema' do
      get "/accounts/#{@account.id}", {}, auth
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end

  describe 'PATCH /accounts/:id' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      data = MultiJson.encode({
        user_id: 12345,
      })
      patch "/accounts/#{@account.id}", data, auth
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end

  describe 'DELETE /accounts/:id' do
    it 'returns correct status code and conforms to schema' do
      delete "/accounts/#{@account.id}", {}, auth
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end
end
