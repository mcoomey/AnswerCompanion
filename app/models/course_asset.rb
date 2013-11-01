class CourseAsset < ActiveRecord::Base
  attr_accessible :name, :model_type, :course_id, :ancestry
  
  has_many :textbook_delegations, dependent: :destroy
  has_many :textbooks, :through => :textbook_delegations, dependent: :destroy
  has_many :videos
  has_many :documents
  has_many :links
  has_many :textboxes
  
  belongs_to :course
  
  has_ancestry
  
	validates :name, :presence => true
	validates :name, :uniqueness => { :scope => [:course_id], :message => " already exists."}
  validates :model_type, :presence => true
end
