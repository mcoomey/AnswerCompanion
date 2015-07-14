class School < ActiveRecord::Base
  attr_accessible :name, :state_id, :town
  belongs_to :state
  has_many :school_memberships
  has_many :instructors, :through => :school_memberships, :source => :schoolmember, :source_type => 'Instructor'
  has_many :students, :through => :school_memberships, :source => :schoolmember, :source_type => 'Student'
  
  validates :name, :presence => { message: " can not be blank."}
  validates :town, :presence => { message: "can not be blank."}
  validates :state_id, :presence => { message: "invalid abbreviation."}
  
  def state_abbrev
    State.find_by_id(state_id).abbrev if state_id
  end
  
  def state_abbrev=(val)
    state = State.find_by_abbrev(val)
    if state
      self.state_id = state.id
    else
      self.state_id = nil
    end
  end
  
  def members
    self.instructors + self.students
  end
end
