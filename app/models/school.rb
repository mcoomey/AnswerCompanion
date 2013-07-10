class School < ActiveRecord::Base
  attr_accessible :name, :state, :town
  has_many :school_memberships
  has_many :instructors, :through => :school_memberships, :source => :schoolmember, :source_type => 'Instructor'
  has_many :students, :through => :school_memberships, :source => :schoolmember, :source_type => 'Student'
  
  # validates :name, :presence => { :message => " can not be blank. School has not been added."}
end
