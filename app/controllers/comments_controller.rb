class CommentsController < ApplicationController

	before_action :authenticate_user!

	def new
		@comment = Comment.new(link_id: params[:link_id], parent_id: params[:parent_id])
	end

	def create
		# binding.pry
		if params[:comment][:parent_id].to_i > 0
			parent = Comment.find_by_id(params[:comment][:parent_id])
			# binding.pry
			@comment = parent.children.build(comment_params)
		else
			@comment = Comment.new(comment_params)
		end

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