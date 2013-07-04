class Role < ActiveRecord::Base
  has_many :role_assignments
  attr_accessible :name
end
