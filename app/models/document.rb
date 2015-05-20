class Document < ActiveRecord::Base
  attr_accessible :archived, :course_id, :subject_id, :course_asset_id, :description, :filename, :type, :position, :docfile
  
  belongs_to :course_asset
  
  mount_uploader :docfile, DocfileUploader
  
  after_destroy :remove_id_directory
  
  
  # remove the id_directory after its content has been destroyed
  def remove_id_directory
    orig_dir = File.expand_path("..", Rails.root.to_s + "/public" + docfile_url)
    FileUtils.rm_rf(orig_dir)
  end

end
