require 'video_model_mixin.rb'

class Video < ActiveRecord::Base
  attr_accessor :replace_flag, :course_id, :subject_id
  attr_accessible :videofile, :title, :description, :length, :videofile_processed, :position, :archived, :course_asset_id, :instructor_id, :replace_flag, :old_version_id
  belongs_to :course_asset
  belongs_to :instructor
  
  mount_uploader :videofile, VideofileUploader
  before_create :get_video_duration  
  # after_save :do_video_conversion
  after_destroy :remove_id_directory

  include VideoModelMixin
  
end
