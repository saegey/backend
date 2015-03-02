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
        params.merge! MultiJson.decode(request.env["rack.input"].read)

        user = User.new
        user.update(
          first_name: params[:first_name],
          last_name: params[:last_name],
          email: params[:email],
          password: params[:password],
          account_id: params[:account_id]
        )
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
        params.merge! MultiJson.decode(request.env["rack.input"].read)

        user = User.first(
          id: params[:id],
          account_id: session[:account_id]
        ) || halt(404)
        
        user.update(
          first_name: params[:first_name],
          last_name: params[:last_name],
          email: params[:email],
          password: params[:password]
        )

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
        user = User.first(
          id: params[:id],
          account_id: session[:account_id]
        ) || halt(404)
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
