class Enrollment < ActiveRecord::Base
  belongs_to :subject
  belongs_to :course
  
	validates :course_id, :uniqueness => { :scope => :subject_id, :message => " already enrolled."}
end
