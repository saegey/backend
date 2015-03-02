module Endpoints
  class Users < Base
    namespace "/v1/users" do
      before do
        content_type :json, charset: 'utf-8'
      end

      get do
        authorize!
        user = User.where(account_id: session[:account_id])
        encode serialize(user)
      end

      post do
        data =  MultiJson.decode(request.env["rack.input"].read)

        user = User.new
        user.first_name = data["first_name"]
        user.last_name = data["last_name"]
        user.email = data["email"]
        user.password = data["password"]
        user.account_id = data["account_id"] if data.include? 'account_id'
        user.save

        status 201
        encode serialize(user)
      end

      get "/:id" do |id|
        authorize!
        user = User.first(id: params[:id]) || halt(404)
        encode serialize(user)
      end

      patch "/:id" do
        authorize!
        data =  MultiJson.decode(request.env["rack.input"].read)

        user = User.first(id: params[:id]) || halt(404)
        user.first_name = data["first_name"] if data.include? 'first_name'
        user.last_name = data["last_name"] if data.include? 'last_name'
        user.email = data["email"]  if data.include? 'email'
        user.password = data["password"]  if data.include? 'password'

        if user.valid?
          user.save
          encode serialize(user)
        else
          status 400
          encode user.errors
        end
      end

      delete "/:id" do
        authorize!
        user = User.first(id: params[:id]) || halt(404)
        user.destroy
        encode serialize(user)
      end

      private

      def serialize(data, structure = :default)
        Serializers::User.new(structure).serialize(data)
      end
    end
  end
end
