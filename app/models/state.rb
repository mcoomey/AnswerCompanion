class State < ActiveRecord::Base
  attr_accessible :country_id, :name
  has_many :schools
  belongs_to :country
end
