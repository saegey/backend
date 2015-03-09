module Helpers
  def authorize!
    if session[:user_id]
      return
    else
      if env['HTTP_AUTHORIZATION']
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
