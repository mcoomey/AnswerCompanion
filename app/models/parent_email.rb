class ParentEmail < ActiveRecord::Base
  attr_accessible :email, :student_id
  belongs_to :student
   
  validates :email, :uniqueness => { :scope => :student_id, :message => " already added."}
end
