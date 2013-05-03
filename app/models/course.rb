class Course < ActiveRecord::Base
  
  attr_accessible :name, :section, :instructor, :term, :archived
  
  belongs_to :instructor
  has_many :textbook_delegations, :as => :textable
  has_many :textbooks, :through => :textbook_delegations
  has_many :enrollments
  
	validates :name, :presence => true
	validates :name, :uniqueness => { :scope => [:instructor_id, :section], :message => " already exists."}
end
