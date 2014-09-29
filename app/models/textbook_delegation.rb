class TextbookDelegation < ActiveRecord::Base
  belongs_to :course_asset
	belongs_to :textbook

  def isbn13
    @isbn13_text
  end
  
  def isbn13=(val)
    @isbn13_text = val
  end
   
end
