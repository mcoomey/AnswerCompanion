class TextbookDelegation < ActiveRecord::Base
  belongs_to :course_asset
	belongs_to :textbook
	
end
