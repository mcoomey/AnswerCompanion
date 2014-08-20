class Lesson < ActiveRecord::Base
  belongs_to :textbook
  belongs_to :instructor
  has_many :textbook_videos, as: :videoable
  
	validates_presence_of  :title, :message => "-- You must specify a title."
	validates_presence_of  :page, :message => "-- You must specify the page."
  
  def is_page_roman?
    if self.page =~/(^M{0,4}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$)/
      return true
    else
      return false
    end
  end
  
end
