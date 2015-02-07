require "spec_helper"

describe Endpoints::Accounts do
  include Committee::Test::Methods
  include Rack::Test::Methods

  def app
    Routes
  end

  def schema_path
    "./docs/schema.json"
  end

  before do
    @account = Account.create

    # temporarily touch #updated_at until we can fix prmd
    @account.updated_at
    @account.save
  end

  describe 'GET /accounts' do
    it 'returns correct status code and conforms to schema' do
      get '/accounts'
      expect(last_response.status).to eq(200)
      assert_schema_conform
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
      get "/accounts/#{@account.uuid}"
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end

  describe 'PATCH /accounts/:id' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      patch "/accounts/#{@account.uuid}", MultiJson.encode({})
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end

  describe 'DELETE /accounts/:id' do
    it 'returns correct status code and conforms to schema' do
      delete "/accounts/#{@account.uuid}"
      expect(last_response.status).to eq(200)
      assert_schema_conform
    end
  end
end
