class Course < ActiveRecord::Base
  
  attr_accessible :name, :section, :instructor, :term, :archived
  belongs_to :instructor
  
	validates :name, :uniqueness => { :scope => [:instructor_id, :section], :message => " already exists."}
end
