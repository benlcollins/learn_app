class SavedjobsController < ApplicationController

	before_action :authenticate_user!

	def create
		user = current_user[:id]
		job = Savedjob.new(:user_id => user, :job_id => params[:job_id], :title => params[:title])
		job.save
		redirect_to links_path
	end

	def destroy
		job = Savedjob.find(params[:id])
		job.destroy
		redirect_to links_path
	end

end