module Endpoints
  class Root < Base
    get '/auth/:provider/callback' do
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

    get '/auth/password' do
      user = User.authenticate(params[:email], params[:password]) || halt(401)
      session = {session: user.id, account_id: user.account_id}
      encode serialize(user)
    end

    get "/auth/logout" do
      halt(401) unless session[:user_id]
      session.clear
    end

    get "/session" do
      halt(401) unless session[:user_id]
      encode session
    end


    private

    def serialize(data, structure = :default)
      Serializers::User.new(structure).serialize(data)
    end
  end
end
