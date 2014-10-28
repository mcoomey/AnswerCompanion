class SectionTitle < ActiveRecord::Base
  belongs_to :textbook
  has_many :exercises
  
	validates_presence_of  :name, :message => "-- Section Title can not be blank."
  
end
