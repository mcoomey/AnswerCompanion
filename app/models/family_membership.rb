class FamilyMembership < ActiveRecord::Base
  attr_accessible :familymember_id, :familymember_type, :student_id
  belongs_to :student
  belongs_to :familymember, :polymorphic => true
  
end
