class TextbookDelegation < ActiveRecord::Base
  belongs_to :course_asset
	belongs_to :textbook
	
  acts_as_list scope: 'course_asset_id = #{course_asset_id} AND archived = #{archived}'

  def isbn13
    @isbn13_text
  end
  
  def isbn13=(val)
    @isbn13_text = val
  end
end
