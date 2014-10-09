module VideoModelMixin

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
    self.delay.my_convert_to_html5(videofile_url) if !video_processed?
    # self.my_convert_to_html5(videofile_url) if !video_processed?
  end

  def my_convert_to_html5(original_video)

    # desired formats for html5 web display for all supported browsers
    formats = ["mp4", "ogv", "webm"]

    # build path to video and isolate the extension
    fpath = Rails.root.to_s + "/public" + original_video
    f_ext = File.extname(fpath)[1..-1] # fpath[/(\.[^.]+$)/][1..-1]

    # create a new Voyeur object to process
    videobj = Voyeur::Media.new( filename: "#{fpath}")

    # do the conversion for each desired format keeping track of errors
    error_flag = 0
    formats.each do |fmt|
      if error_flag == 0
        # don't bother processing video if it is already the targetted format
        if f_ext.casecmp(fmt) != 0 
          exitstatus = videobj.convert( to: fmt.to_sym)
    
          # check for processing error, set error_flags and send failure notification
          if exitstatus[:status] > 0
            error_flag = 1
            UserMailer.conversion_failed(Instructor.find_by_id(instructor_id).email, self, exitstatus).deliver
            update_attribute :videofile_processed, -1
          end
        end  # if f_ext
      end
    end  # formats.each

    # if there were no processing errors
    if error_flag == 0
      
      # check to see if video is being replaced
      if self.old_version_id
        old_video = Video.find_by_id(self.old_version_id)
        old_video.videofile = self.videofile
        if old_video.save
          update_attribute :videofile_processed, 1
          UserMailer.conversion_complete(Instructor.find_by_id(instructor_id).email, self, nil).deliver
        else
          update_attribute :videofile_processed, -1
        end

      # else video is being created
      else        
        update_attribute :videofile_processed, 1
        UserMailer.conversion_complete(Instructor.find_by_id(instructor_id).email, self, nil).deliver
      end
      
    # else there was a processing error
    else
      update_attribute :videofile_processed, -1
    end
       
  end

  def processed_video_url(format=:mp4)
   videofile_url.chomp(File.extname(videofile_url)) + "." + format.to_s
  end

  def video_processed?
   videofile_processed && videofile_processed > 0
  end
end