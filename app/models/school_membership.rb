class SchoolMembership < ActiveRecord::Base
  attr_accessible :school_id, :schoolmember_id, :schoolmember_type
  belongs_to :school
  belongs_to :schoolmember, :polymorphic => true
end
