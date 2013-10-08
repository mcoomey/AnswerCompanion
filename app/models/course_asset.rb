class CourseAsset < ActiveRecord::Base
  attr_accessible :parent_id, :model, :name
  
  has_many :textbook_delegations, dependent: :destroy
  has_many :textbooks, :through => :textbook_delegations, dependent: :destroy
  belongs_to :course
  
  has_ancestry
end
