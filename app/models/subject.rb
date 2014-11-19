class Subject < ActiveRecord::Base
	
  attr_accessible :name, :description, :term, :archived
	belongs_to :student
  has_one :enrollment
  has_one :course, :through => :enrollment, dependent: :destroy
  has_many :course_assets, :as => :assetable, dependent: :destroy
  
	validates :name, :uniqueness => { :scope => [:student_id, :archived], :message => " already exists."}
	validates :name, :presence => true
	
end
