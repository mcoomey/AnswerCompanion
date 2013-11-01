class Document < ActiveRecord::Base
  attr_accessible :archived, :course_asset_id, :description, :filename, :type
  
  belongs_to :course_asset
  
end
