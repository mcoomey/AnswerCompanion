class Textbook < ActiveRecord::Base
  attr_accessible :isbn13, :title, :author, :publisher, :image_link
  has_many :textbook_delegations, dependent: :destroy
  has_many :course_assets, :through => :textbook_delegations, dependent: :destroy
	has_many :section_titles
	has_many :lessons
	has_many :exercises
	has_many :textbook_videos
		
	validates_presence_of  :isbn13, :message => "-- You must specify the ISBN."
	validates_uniqueness_of :isbn13, :message => "-- That ISBN already exists."
	
  def thumbnail
    image_link.gsub("zoom=1", "zoom=5")
  end
  
end
