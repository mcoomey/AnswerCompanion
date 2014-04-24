class Textbox < ActiveRecord::Base
  attr_accessible :archived, :title, :content, :course_asset_id
  
  belongs_to :course_asset
end
