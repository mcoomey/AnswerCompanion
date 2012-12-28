class Video < ActiveRecord::Base
  attr_accessible :videofile, :length, :feedback_score, :difficulty, :numpurchases, :archived, :newversion_id, :exercise_id, :instructor_id, :textbook_id
  belongs_to :exercise
  belongs_to :lesson
  belongs_to :instructor
  belongs_to :textbook
  has_one :newversion, :class_name => "Video", :foreign_key => "newversion_id"
  
	validates_presence_of  :videofile, :message => "-- You must specify a video file."
	
  mount_uploader :videofile, VideofileUploader
  
  
  def get_video_duration
    fpath = Rails.root.to_s + "/public" + self.videofile_url
    result = `ffmpeg -i #{fpath} 2>&1`
    r = result.match("Duration: ([0-9]+):([0-9]+):([0-9]+).([0-9]+)")
    if r
      self.length = r[1] + ':' + r[2] + ':' + r[3] + '.' + r[4]
    end
  end
  
  def my_convert_to_html5
    formats = ["mp4", "ogv", "webm"]
    fpath = Rails.root.to_s + "/public" + self.videofile_url
    f_ext = fpath[/(\.[^.]+$)/][1..-1]
    puts "******* extension = #{f_ext} *********"
    videobj = Voyeur::Media.new( filename: "#{fpath}")
    formats.each do |fmt|
      if f_ext.casecmp(fmt) != 0 
        exitstatus = videobj.convert( to: fmt.to_sym) do |time|
          media_time = Voyeur::MediaTime.new(time).to_seconds
          duration = Voyeur::MediaTime.new(videobj.raw_duration).to_seconds
          percentage = (media_time.to_f/duration.to_f) * 100
          puts "#{'%.2f' % percentage} % complete"
          print "#{'%.2f' % percentage} % complete"
          self.progress = percentage
        end
        puts "************ Exit Status = #{exitstatus} ****************"
      end
    end
    puts "*************************** done with Voyeur *************************************"
   end
   
end
