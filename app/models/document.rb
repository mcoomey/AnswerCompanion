class Document < ActiveRecord::Base
  attr_accessible :archived, :course_asset_id, :description, :filename, :type, :position, :docfile
  
  belongs_to :course_asset
  
  mount_uploader :docfile, DocfileUploader
  
end
