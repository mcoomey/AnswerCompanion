class Exercise < ActiveRecord::Base
  belongs_to :section_title
  belongs_to :textbook
  belongs_to :instructor
  has_many :videos
  
	validates_presence_of  :number, :message => "-- You must specify an example number."
	validates_presence_of  :page, :message => "-- You must specify the page."
  
  def section_title_name
    section_title.try(:name)
  end
  
  def section_title_name=(name)
    puts ">>>>>>>>>>>>>setting section_title_name to #{name} with textbook_id = #{self.textbook_id}<<<<<<<<<<<<<<<<<<"
    self.section_title = SectionTitle.create_with(textbook_id: self.textbook_id).find_or_initialize_by_name(name)
  end
  
end
