class User < ActiveRecord::Base
	has_many	:blogs
	has_many    :forum_posts
	has_one     :profile
	has_many    :collects
    has_many    :collected_courses, :through=>:collects, :source=>:course
    has_many    :owned_courses, :foreign_key=>"author_id"

    before_save :add_profile
	devise :database_authenticatable, :rememberable, :trackable, :validatable, :registerable	

	def add_profile
	  self.profile = Profile.new()
	end
end
