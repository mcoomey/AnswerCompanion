class Subject < ActiveRecord::Base
	
  attr_accessible :name, :description, :term, :archived
	belongs_to :student
  has_many :enrollments
  
	validates :name, :uniqueness => { :scope => :student_id, :message => " already exists."}
	validates :name, :presence => true
	

end
