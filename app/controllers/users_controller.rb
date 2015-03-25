class UsersController < ApplicationController

	def show
		@user = User.find(params[:id])
		@links = @user.links.reverse
		@favorites = @user.favorites
		@savedjobs = @user.savedjobs

		# grab user's gravatar, if they have one
		hash = Digest::MD5.hexdigest(@user.email)
		@image_src = "http://www.gravatar.com/avatar/#{hash}"
	end

end