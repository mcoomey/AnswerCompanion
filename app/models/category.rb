class Category < ActiveRecord::Base
	has_many :subjects
	has_many :textbooks
	has_many :subcategories
end
