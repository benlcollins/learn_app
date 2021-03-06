class SavedjobsController < ApplicationController

	before_action :authenticate_user!

	def create
		user = current_user[:id]
		job = Savedjob.new(:user_id => user, :job_id => params[:job_id], :title => params[:title])
		job.save
		flash[:notice] = "Job successfully added to your saved jobs"
		redirect_to request.referrer
	end

	def destroy
		job = Savedjob.find(params[:id])
		job.destroy
		flash[:alert] = "Job removed from your saved jobs"
		redirect_to request.referrer
	end

end