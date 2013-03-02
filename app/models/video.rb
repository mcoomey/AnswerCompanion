class Video < ActiveRecord::Base
  attr_accessible :videofile, :length, :feedback_score, :difficulty, :numpurchases, :archived, :newversion_id, :exercise_id, :instructor_id, :textbook_id
  belongs_to :exercise
  belongs_to :lesson
  belongs_to :instructor
  belongs_to :textbook
  has_one :newversion, :class_name => "Video", :foreign_key => "newversion_id"
	
  mount_uploader :videofile, VideofileUploader
  
  before_create :get_video_duration  
  after_destroy :remove_id_directory
  
  def get_video_duration
    fpath = Rails.root.to_s + "/public" + self.videofile_url
    result = `ffmpeg -i #{fpath} 2>&1`
    r = result.match("Duration: ([0-9]+):([0-9]+):([0-9]+).([0-9]+)")
    if r
      self.length = r[1] + ':' + r[2] + ':' + r[3] + '.' + r[4]
    else
      self.length = 'ERROR'
    end
  end
  
   def remove_id_directory
     store_dir = videofile.store_dir
     remove_videofile!
     FileUtils.remove_dir("#{Rails.root}/public/#{store_dir}", :force => true)
   end


end
