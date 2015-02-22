module Helpers
  def authorize!
    halt(401) unless session[:user_id]
  end
end