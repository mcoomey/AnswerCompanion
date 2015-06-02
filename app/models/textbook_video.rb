require 'video_model_mixin.rb'

class TextbookVideo < ActiveRecord::Base
  attr_accessor :replace_flag, :course_id, :subject_id
  attr_accessible :instructor_id, :length, :textbook_id, :videoable_id, :videoable_type, :videofile, :videofile_processed, :replace_flag, :old_version_id
  belongs_to :videoable, polymorphic: true
  belongs_to :instructor
  belongs_to :textbook
	
  mount_uploader :videofile, VideofileUploader
  before_create :get_video_duration  
  # after_save :do_video_conversion
  after_destroy :remove_id_directory
  
  include VideoModelMixin
  
end
