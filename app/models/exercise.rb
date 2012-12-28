class Exercise < ActiveRecord::Base
  belongs_to :section_title
  belongs_to :textbook
  belongs_to :instructor
  has_many :videos
  
end
