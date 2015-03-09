module Helpers
  def check_version!
    if env["HTTP_ACCEPT"] != "application/vnd.fobless+json; version=1"
      halt(400, MultiJson.encode({id: :bad_version}))
    end
  end

  def authorize!
  	halt(401) unless session[:user_id]
  end
end
