class Exercise < ActiveRecord::Base
  belongs_to :section_title
  belongs_to :textbook
  belongs_to :instructor
  has_many :textbook_videos, as: :videoable
  
  before_destroy :destroy_lone_section_title
  
	validates_presence_of  :number, :message => "-- You must specify an example number."
	validates_presence_of  :page, :message => "-- You must specify the page."
  
  def section_title_name
    section_title.try(:name)
  end
  
  def section_title_name=(name)
    self.section_title = SectionTitle.create_with(textbook_id: self.textbook_id).find_or_initialize_by_name(name)
  end
  
  private
  
  def destroy_lone_section_title
    st = self.section_title
    if st.exercises.count == 1
      st.destroy
    end
  end
  
end
