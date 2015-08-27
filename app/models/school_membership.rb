class SchoolMembership < ActiveRecord::Base
  attr_accessible :school_id, :schoolmember_id, :schoolmember_type, :school_attributes
  belongs_to :school
  belongs_to :schoolmember, :polymorphic => true
  
  accepts_nested_attributes_for :school, allow_destroy: true
  
  
end
