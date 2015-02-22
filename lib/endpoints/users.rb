module Endpoints
  class Users < Base
    namespace "/users" do
      before do
        content_type :json, charset: 'utf-8'
      end

      get do
        authorize!
        user = User.first(id: session[:user_id])
        encode serialize(user)
      end

      post do
        params =  MultiJson.decode(request.env["rack.input"].read)

        user = User.new
        user.first_name = params["first_name"]
        user.last_name = params["last_name"]
        user.email = params["email"]
        user.password = params["password"]
        user.save

        status 201
        encode serialize(user)
      end

      patch "/:id" do |id|
        data =  MultiJson.decode(request.env["rack.input"].read)

        user = User.first(id: session[:user_id]) || halt(404)
        user.first_name = data["first_name"]
        user.last_name = data["last_name"]
        user.email = data["email"]
        user.password = data["password"]

        if user.valid?
          user.save
          encode serialize(user)
        else
          encode user.errors
        end
      end

      delete "/:id" do |id|
        user = User.first(id: id) || halt(404)
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
