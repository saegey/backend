module Endpoints
  class Users < Base
    namespace "/users" do
      before do
        # halt(401) unless session[:user_id]
        content_type :json, charset: 'utf-8'
      end

      get do
        users = User.where(account_id: session[:account_id])
        encode serialize(users)
      end

      post do
        account = Account.new
        account.save
        
        user = User.new
        user.first_name = params[:first_name]
        user.last_name = params[:last_name]
        user.account = account
        user.email = params[:email]
        user.password = params[:password]
        user.save
        status 201
        encode serialize(user)
      end

      get "/:id" do |id|
        user = User.first(uuid: params[:id]) || halt(404)
        encode serialize(user)
      end

      patch "/:id" do |id|
        user = User.first(uuid: params[:id]) || halt(404)
        user.first_name = params[:first_name]
        user.last_name = params[:last_name]
        user.email = params[:email]

        if user.valid?
          user.save
          encode serialize(user)
        else
          encode user.errors
        end
      end

      delete "/:id" do |id|
        user = User.first(uuid: id) || halt(404)
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
