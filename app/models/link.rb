class Link < ActiveRecord::Base
  attr_accessible :archived, :course_asset_id, :description, :url
  
  belongs_to :course_asset
  
	validates :url, :presence => true
  
end
