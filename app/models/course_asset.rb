class CourseAsset < ActiveRecord::Base
  belongs_to :course
  attr_accessible :name, :type
  
  has_ancestry
end
