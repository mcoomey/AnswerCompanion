class CourseAsset < ActiveRecord::Base
  attr_accessible :name, :model_type, :position
  
  has_many :textbook_delegations, dependent: :destroy
  has_many :textbooks, :through => :textbook_delegations, dependent: :destroy
  has_many :videos
  has_many :documents
  has_many :links
  has_many :textboxes
  
  belongs_to :assetable, :polymorphic => true
    
	validates :name, :presence => true
	validates :name, :uniqueness => { :scope => [:assetable_id, :assetable_type], :message => " already exists."}
  validates :model_type, :presence => true
end
