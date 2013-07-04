class RoleAssignment < ActiveRecord::Base
  belongs_to :roleable, :polymorphic => true
  belongs_to :role
  
  attr_accessible :role_id, :roleable_id, :roleable_type
end
