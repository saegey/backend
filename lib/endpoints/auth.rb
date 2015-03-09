module Endpoints
  class Auth < Base
    namespace "/v1/auth" do
      before do
        content_type :json, charset: 'utf-8'
      end

      get '/:provider/callback' do
        user = User.find(
          provider: params[:provider],
          provider_id: request.env['omniauth.auth']['uid']
        )

        if user
          session[:user_id] = user.id
          session[:account_id] = user.account_id
          encode serialize(user)
        else
          user = Mediators::UserSignup.run({
            provider: params[:provider],
            uid: request.env['omniauth.auth']['uid']
          })
          encode serialize(user)
        end
      end

      post '/password' do
        data =  MultiJson.decode(request.env["rack.input"].read)
        user = User.authenticate(data["email"], data["password"]) || halt(401)
        session[:user_id] = user.id
        session[:account_id] = user.account_id
        encode({token: session.id})
      end

      get "/logout" do
        halt(401) unless session[:user_id]
        user = User.first(id: session[:user_id]) || halt(401)
        session.clear
        encode serialize(user)
      end

      private

      def serialize(data, structure = :default)
        Serializers::User.new(structure).serialize(data)
      end
    end
  end
end
