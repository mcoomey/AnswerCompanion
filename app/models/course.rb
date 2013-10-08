class Course < ActiveRecord::Base
  
  attr_accessible :name, :section, :instructor, :term, :archived
  
  belongs_to :instructor
  has_many :enrollments, dependent: :destroy
  has_many :course_assets, dependent: :destroy
  
	validates :name, :presence => true
	validates :name, :uniqueness => { :scope => [:instructor_id, :section], :message => " already exists."}
end
