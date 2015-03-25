class PagesController < ApplicationController

	def about
	end

	def show_jobs
		response = HTTParty.get("https://jobs.github.com/positions/#{params[:id]}.json")
		@result = JSON.parse(response.body)
		@savedjob = Savedjob.find_by(job_id: params[:id])
		# binding.pry
		if !@savedjob
			@savedjob = Savedjob.new
		end
	end

end