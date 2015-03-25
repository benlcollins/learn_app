class LinksController < ApplicationController

	before_action :authenticate_user!, except: [:index, :show]
	before_action :link_find, except: [:index, :new, :create, :show_jobs]

	def index
		# basic search functionality
		if params[:search]
			@links = Link.where("title LIKE ?", "%#{params[:search]}%")
		elsif params[:tag]
			@links = Link.tagged_with(params[:tag])
		else
			@links = Link.all
		end

		# group all of the links into date groups
		@grouped_links = @links.order("created_at").reverse.group_by { |link| link.created_at.to_date }
		
		# if user is signed in, pass all their favorites into @favorite instance variable
		if user_signed_in?
			@favorites = current_user.favorites.map do |fav|
				fav.link_id
			end
		end
		@favorite = Favorite.new

		# code to pull github jobs
		if params[:tag]
			description = params[:tag].gsub(' ','+')
		end
		response = HTTParty.get("https://jobs.github.com/positions.json?description=#{description}")
		result = JSON.parse(response.body)

		@result = []
		num = [result.count, 15].min
		i = 0
		while i < num do
			@result.push(result[i])
			i += 1
		end
	end

	def show
		@url = @link.link_url

		# call to Browshot api to grab screenshot, created when link submitted
		# try javascript - check ready state, complete, loaded? 
		# rescu (for future reference)
		# make call out to browshot api for screen capture
		@key = ENV['API_KEY']
		client = Browshot.new(@key)
		screenshot = client.screenshot_create(@url, { 'instance_id' => 12 })
		@image_id = screenshot["id"]

		# code to pull github jobs
		if params[:tag]
			description = params[:tag].gsub(' ','+')
		end
		response = HTTParty.get("https://jobs.github.com/positions.json?description=#{description}")
		result = JSON.parse(response.body)

		@result = []
		num = [result.count, 10].min
		i = 0
		while i < num do
			@result.push(result[i])
			i += 1
		end

	end

	def new
		@link = Link.new
	end

	def create
		# setup new link
		@link = Link.new(strong_upload_params)
		year = params[:date][:year]
		@link.year = year
		@link.user_id = current_user[:id]

		# call to Browshot api to grab screenshot
		@url = @link.link_url
		binding.pry
		@key = ENV['API_KEY']
		client = Browshot.new(@key)
		screenshot = client.screenshot_create(@url, { 'instance_id' => 12 })

		# save new link to database
		if @link.save
			flash[:notice] = "Link submitted successfully"
			redirect_to links_path
		else
			flash[:alert] = "Link not saved"
			render :new
		end
	end

	def edit
	end

	def update
		year = params[:date][:year]
		@link.year = year
		if @link.update(strong_upload_params)
			flash[:notice] = "Link updated successfully"
			redirect_to links_path
		else
			flash[:alert] = "Link not updated"
			render :edit
		end
	end

	def destroy
		@link.destroy
		flash[:alert] = "Link deleted"
		redirect_to links_path
	end

	private

	def strong_upload_params
		params.require(:link).permit(:title, :link_url, :year, :about_link, :tag_list)
	end

	def link_find
		@link = Link.find(params[:id])
	end

end