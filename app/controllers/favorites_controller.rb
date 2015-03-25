class FavoritesController < ApplicationController

	before_action :authenticate_user!

	
	def create
		# could not get this method to work
		# favorite_params = params.require(:favorite).permit(:link_id)
		# favorite = Favorite.new(favorite_params)
		# favorite = Favorite.new(favorite_params)
		# favorite.user_id = current_user[:id]

		# so used this one instead
		user = current_user[:id]
		link = params[:link_id]
		title = Link.find(link)[:title]
		favorite = Favorite.new(:link_id => link, :user_id => user, :title => title)
		favorite.save
		flash[:notice] = "Resource successfully added to your profile"
		redirect_to user_path(current_user[:id])
		# redirect_to links_path
	end

	def destroy
		favorite = Favorite.find(params[:id])
		favorite.destroy

		# find out which page user is on, to redirect to appropriate place
		# page = request.fullpath


		flash[:alert] = "Resource successfully removed from your profile"
		redirect_to user_path(current_user[:id])
		# redirect_to links_path
	end

	# trying to get alternative routing working for fav/unfav depending on where user is
	# def destroy_from_user_page
	# 	favorite = Favorite.find(params[:id])
	# 	favorite.destroy
	# 	redirect_to user_path(current_user[:id])
	# end

end
