module Helpers
  def check_version!
    if env["HTTP_ACCEPT"] != "application/vnd.fobless+json; version=1"
      halt(400, MultiJson.encode({id: :bad_version}))
    end
  end

  def authorize!
    if session[:user_id]
      return
    else
      if env['HTTP_AUTHORIZATION']
        redis = Redis.new()
        auth_token = redis.get(env['HTTP_AUTHORIZATION'])
        if auth_token
          session = Marshal.load(auth_token)
          return
        end
      end
      halt(401)
    end
  end
end
