class CommentsController < ApplicationController

	before_action :authenticate_user!

	def new
		@comment = Comment.new(link_id: params[:link_id])
	end

	def create
		@comment = Comment.new(comment_params)
		link_id = params[:comment][:link_id].to_i
		@comment.link_id = link_id
		@comment.user_id = current_user.id
		# binding.pry
		if @comment.save
			redirect_to link_path(Link.find(link_id))
		else
			render :new
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:body)
	end

end