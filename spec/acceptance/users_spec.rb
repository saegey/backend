require "spec_helper"

describe Endpoints::Users do
  include Committee::Test::Methods
  include Rack::Test::Methods
  include RSpec::Matchers

  # let(:body) { { :first_name => "test"}.to_json }

  before do
    @user = User.create({
      email: "test@test.com",
      first_name: "Bob",
      last_name: "Jones"
    })
    @user.updated_at
    @user.save

    @property = Property.new
    @property.name = 'test property'
    @property.account_id = @user.account_id
    @property.save
  end

  describe 'GET /v1/users' do
    it 'returns correct status code and conforms to schema' do
      get '/v1/users', nil, auth
      
      data = JSON.parse(last_response.body)
      
      expect(last_response.status).to eq(200)
      # expect(last_response).to match_response_schema("user")
      # expect(data["account"]["id"]).to eq(@user.account_id)
      # expect(data["email"]).to eq(@user.email)
    end
  end

  describe 'POST /v1/users' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      data = {
        first_name: "John", 
        last_name: "Jones", 
        email: "test@test.com",
        password: "test123"
      }
      post '/v1/users', MultiJson.encode(data)
      expect(last_response.status).to eq(201)
      expect(last_response).to match_response_schema("user_create")
    end
  end

  describe 'PATCH /v1/users' do
    it 'returns correct status code and conforms to schema' do
      header "Content-Type", "application/json"
      data = {first_name: "John", last_name: "Jones", email: "test@test.com", password: "test123"}
      patch "/v1/users/#{@user.id}", MultiJson.encode(data), auth
      expect(last_response.status).to eq(200)
      expect(last_response).to match_response_schema("user")
    end
  end

  describe 'DELETE /v1/users/:id' do
    it 'returns correct status code and conforms to schema' do
      delete "/v1/users/#{@user.id}"
      expect(last_response.status).to eq(200)
      expect(last_response).to match_response_schema("user")
      expect(User.first(id: @user.id)).to be_nil
    end
  end
end
