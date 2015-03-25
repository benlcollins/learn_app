class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :user_gravatar

  def user_gravatar
  	# grab the current_user's gravatar
  	hash = Digest::MD5.hexdigest(current_user.email)
	@image_src = "http://www.gravatar.com/avatar/#{hash}"
  end
end
