# require uri parser library
require 'uri'

class Link < ActiveRecord::Base

	belongs_to :user
	has_many :favorites, dependent: :destroy
	has_many :upvotes, dependent: :destroy
	has_many :comments, dependent: :destroy

	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings
	
	validates :title, presence: true, length: { minimum: 2 }
	validates :link_url, presence: true, length: { minimum: 5 }, uniqueness: true

	before_save :url_check

	# setter method for tag_list
	def tag_list=(names)
		self.tags = names.split(",").map do |name|
			Tag.where(name: name.strip).first_or_create!
		end
	end

	# getter method for tag_list
	def tag_list
		self.tags.map(&:name).join(", ")
	end

	def self.tagged_with(name)
		Tag.find(name).links
	end

	# new stuff
	protected

	def url_check
		u = URI(self.link_url)
		if (!u.scheme)
			self.link_url = "http://#{self.link_url}"
		end
	end

end