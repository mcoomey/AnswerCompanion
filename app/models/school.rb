class School < ActiveRecord::Base
  attr_accessible :name, :state, :town
  has_and_belongs_to_many :instructors
end
