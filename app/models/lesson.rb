class Lesson < ActiveRecord::Base
  belongs_to :textbook
  belongs_to :instructor
  has_many :videos
  
	validates_presence_of  :title, :message => "-- You must specify a title."
	validates_presence_of  :page, :message => "-- You must specify the page."
end
