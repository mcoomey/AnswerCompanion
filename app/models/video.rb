class Video < ActiveRecord::Base
  attr_accessible :videofile, :length, :archived, :newversion_id, :instructor_id, :textbook_id, :title, :description
  belongs_to :videoable, polymorphic: true
  belongs_to :instructor
  belongs_to :textbook
  has_one :newversion, :class_name => "Video", :foreign_key => "newversion_id"
	
  mount_uploader :videofile, VideofileUploader
  
  before_create :get_video_duration  
  after_save :do_video_conversion
  after_destroy :remove_id_directory
  
  def get_video_duration
    fpath = Rails.root.to_s + "/public" + videofile.to_s
    result = `ffmpeg -i #{fpath} 2>&1`
    r = result.match("Duration: ([0-9]+):([0-9]+):([0-9]+).([0-9]+)")
    if r
      self.length = r[1] + ':' + r[2] + ':' + r[3] + '.' + r[4]
    else
      self.length = 'ERROR'
    end
  end

  # remove the id_directory after its content has been detroyed
  def remove_id_directory
    orig_dir = File.expand_path("..", Rails.root.to_s + "/public" + videofile_url)
    FileUtils.rm_rf(orig_dir)
  end

  def do_video_conversion
    # self.delay.my_convert_to_html5(videofile_url) if !video_processed?
    self.my_convert_to_html5(videofile_url) if !video_processed?
  end
  
  def my_convert_to_html5(original_video)
    formats = ["mp4", "ogv", "webm"]
    fpath = Rails.root.to_s + "/public" + original_video
    f_ext = File.extname(fpath)[1..-1] # fpath[/(\.[^.]+$)/][1..-1]
    videobj = Voyeur::Media.new( filename: "#{fpath}")
    formats.each do |fmt|
      if f_ext.casecmp(fmt) != 0 
        exitstatus = videobj.convert( to: fmt.to_sym)[:status]
      end  # if f_ext
    end  # formats
    update_attribute :videofile_processed, 1
    UserMailer.conversion_complete(Instructor.find_by_id(instructor_id).email, self).deliver
   end
   
   def processed_video_url(format=:mp4)
     videofile_url.chomp(File.extname(videofile_url)) + "." + format.to_s
   end
   
   def video_processed?
     videofile_processed && videofile_processed > 0
   end
 end
