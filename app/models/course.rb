class Course < ActiveRecord::Base
  
  attr_accessible :name, :section, :instructor, :term, :archived, :passphrase, :position
  
  belongs_to :instructor
  has_many :enrollments, dependent: :destroy
  has_many :subjects, :through => :enrollments
  has_many :course_assets, :as => :assetable, dependent: :destroy
  
	validates :name, :presence => true
	validates :name, :uniqueness => { :scope => [:instructor_id, :section, :term], :message => " already exists."}
  
  def name_and_section
    
    if self.section.length > 0
      self.name + "-" + self.section
    else 
      self.name
    end
    
  end
end
