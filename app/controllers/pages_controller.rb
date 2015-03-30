class PagesController < ApplicationController

	def about
	end

	def show_jobs
		response = HTTParty.get("https://jobs.github.com/positions/#{params[:id]}.json")
		@result = JSON.parse(response.body)
		# binding.pry
		if user_signed_in?
			savedjob = Savedjob.find_by(job_id: params[:id], user_id: current_user[:id])
			# binding.pry
			savedjob.nil? ? @savedjob = Savedjob.new : @savedjob = savedjob
		else
			binding.pry
			@savedjob = Savedjob.new
		end
	end

end