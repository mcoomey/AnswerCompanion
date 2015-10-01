class SchoolMembership < ActiveRecord::Base
  attr_accessible :school_id, :schoolmember_id, :schoolmember_type, :school_attributes
  belongs_to :school
  belongs_to :schoolmember, :polymorphic => true
  before_destroy :pre_delete_orphan_school
  
  accepts_nested_attributes_for :school, allow_destroy: true, reject_if: :all_blank
  
  validates :school_id, :uniqueness => { :scope => [:schoolmember_id, :schoolmember_type], :message => " membership duplication."}
  
  def pre_delete_orphan_school
    if self.school.members.count == 1
      self.school.destroy
    end
  end
  
end
