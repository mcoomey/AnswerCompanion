class ParentEmail < ActiveRecord::Base
  attr_accessible :email, :student_id
  belongs_to :student
   
  validates :email, :uniqueness => { :scope => :student_id, :message => " already added."}
  validates_email_format_of :email, :message => 'is not a valid email format.'
end
