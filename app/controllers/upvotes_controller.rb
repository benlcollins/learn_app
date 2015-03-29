class UpvotesController < ApplicationController

	before_action :authenticate_user!

	def create
		user = current_user[:id]
		# binding.pry
		username = User.find(user).username
		link = params[:link_id]
		title = Link.find(link)[:title]
		upvote = Upvote.new(:link_id => link, :title => title, :user_id => user, :username => username)
		upvote.save
		redirect_to request.referrer
	end

	def destroy
		upvote = Upvote.find(params[:id])
		upvote.destroy
		redirect_to request.referrer
	end

end