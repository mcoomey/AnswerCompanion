class Textbook < ActiveRecord::Base
  attr_accessible :isbn13, :title, :author, :publisher, :image_link, :textbook_image
  has_many :textbook_delegations, dependent: :destroy
  has_many :course_assets, :through => :textbook_delegations, dependent: :destroy
	has_many :section_titles
	has_many :lessons
	has_many :exercises
	has_many :textbook_videos
  
  mount_uploader :textbook_image, TextbookImageUploader
	
  after_destroy :remove_id_directory
  
	validates_presence_of  :isbn13, :message => "-- You must specify the ISBN."
	validates_uniqueness_of :isbn13, :message => "-- That ISBN already exists."
	
  def thumbnail
    image_link.gsub("zoom=1", "zoom=5")
  end
  
  # remove the id_directory after its content has been destroyed
  def remove_id_directory
    orig_dir = File.expand_path("..", Rails.root.to_s + "/public" + textbook_image_url)
    FileUtils.rm_rf(orig_dir)
  end
  
  
end
