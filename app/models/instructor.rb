class Instructor < ActiveRecord::Base
	
	has_many :schools
	has_many :courses
	has_many :videos
	has_many :lessons
	has_many :exercises
	has_many :textbooks
	has_and_belongs_to_many :schools
	
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,  :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :firstname, :lastname, :screenname, :emailpref, :paypalaccount,
                  :role, :privilege, :grade, :accountbalance, :violationcount,
                  :deactivated, :school, :schools_attributes
  accepts_nested_attributes_for :schools
   
#    def school_name
#      if school.try(:name).to_s.length() > 0
#        school.try(:name).to_s + "||" + school.try(:town).to_s + "||" + school.try(:state).to_s
#      else
#        nil
#      end
#    end
#    
#    def school_name=(name_town_state)
#      name, town, state = name_town_state.split("||")
#      self.school = School.where(name: name, town: town, state: state).first_or_initialize if name.present?
#    end
end
