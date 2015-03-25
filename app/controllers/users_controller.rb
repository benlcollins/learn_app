class UsersController < ApplicationController

	def show
		# find the user that has been clicked on (not necessarily the current user)
		@user = User.find(params[:id])
		@links = @user.links.reverse
		@favorites = @user.favorites.reverse
		@savedjobs = @user.savedjobs.reverse

		# grab user's gravatar, if they have one
		hash = Digest::MD5.hexdigest(@user.email)
		@image_src = "http://www.gravatar.com/avatar/#{hash}"
	end

end