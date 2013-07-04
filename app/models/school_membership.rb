class SchoolMembership < ActiveRecord::Base
  attr_accessible :school_id, :schoolmember_id, :schoolmember_type
  belongs_to :school
  belongs_to :schoolmember, :polymorphic => true
  
  validates :school_id, :uniqueness => { :scope => [:schoolmember_id, :schoolmember_type], :message => " already belongs."}
end
