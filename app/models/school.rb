class School < ActiveRecord::Base
  attr_accessible :name, :state, :town
  has_many :instructors
end
