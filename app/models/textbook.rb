class Textbook < ActiveRecord::Base
  attr_accessible :userisbn, :isbn13, :title, :author, :publisher, :edition, :frontcover, :category_id, :subcategory_id, :div, 
                   :subdiv1, :subdiv2, :subdiv3, :frontcover_cache, :remote_frontcover_url, :image_link, :category_name,
                   :subcategory_name
  belongs_to :category
	belongs_to :subcategory
  belongs_to :instructor
  has_many :textbook_delegations, dependent: :destroy
  has_many :course_assets, :through => :textbook_delegations, dependent: :destroy
	has_many :section_titles
	has_many :lessons
	has_many :exercises
	has_many :videos
	
	accepts_nested_attributes_for :category
	accepts_nested_attributes_for :subcategory
	
	mount_uploader :frontcover, FrontcoverUploader
	validates_presence_of  :isbn13, :message => "-- You must specify the ISBN."
	validates_uniqueness_of :isbn13, :message => "-- That ISBN already exists."
	
	def category_name
	  category.try(:name)
	end
	
	def category_name=(name)
	  self.category = Category.find_or_create_by_name(name) if name.present?
	end
	
	def subcategory_name
	  subcategory.try(:name)
	end

	def subcategory_name=(name)
	  self.subcategory = Subcategory.find_or_create_by_name(name, :category_id => self.category_id) if name.present?
	end
end
