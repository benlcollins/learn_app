class FavoritesController < ApplicationController

	before_action :authenticate_user!

	
	def create
		# setup the favorite to save to database
		user = current_user[:id]
		link = params[:link_id]
		title = Link.find(link)[:title]
		favorite = Favorite.new(:link_id => link, :user_id => user, :title => title)
		favorite.save

		flash[:notice] = "Resource successfully added to your profile"

		redirect_to request.referrer
	end

	def destroy
		favorite = Favorite.find(params[:id])
		favorite.destroy
		flash[:alert] = "Resource successfully removed from your profile"
		redirect_to request.referrer
	end

end
