module Endpoints
  class Auth < Base
    namespace "/v1/auth" do
      get '/:provider/callback' do
        user = User.find(
          provider: params[:provider],
          provider_id: request.env['omniauth.auth']['uid']
        )

        if user
          session[:user_id] = user.id
          session[:account_id] = user.account_id
          encode user
        else
          response = Mediators::UserSignup.run({
            provider: params[:provider],
            uid: request.env['omniauth.auth']['uid']
          })
          encode response
        end
      end

      post '/password' do
        data =  MultiJson.decode(request.env["rack.input"].read)

        user = User.authenticate(data["email"], data["password"]) || halt(401)
        session = {session: user.id, account_id: user.account_id}
        encode serialize(user)
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
