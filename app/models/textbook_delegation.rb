class TextbookDelegation < ActiveRecord::Base
  attr_accessible :textbook_attributes
  belongs_to :course_asset
	belongs_to :textbook
end
