class Subject < ActiveRecord::Base
	
	belongs_to :category
	belongs_to :subcategory
	belongs_to :student
  has_many :textbook_delegations, :as => :textable
  has_many :textbooks, :through => :textbook_delegations
  has_many :enrollments
  
	validates :name, :uniqueness => { :scope => :student_id, :message => " already exists."}
	validates :name, :presence => true
	
	accepts_nested_attributes_for :category
	accepts_nested_attributes_for :subcategory
	

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
