class Instructor < ActiveRecord::Base
	
	has_many :role_assignments, :as => :roleable
	has_many :roles, :through => :role_assignments
	has_many :school_memberships, :as => :schoolmember
	has_many :schools, :through => :school_memberships
	has_many :courses, dependent: :destroy
	has_many :videos
	has_many :textbook_videos
	has_many :lessons
	has_many :exercises
	has_many :textbooks
	
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,  :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :firstname, :lastname, :username, :emailpref, :paypalaccount,
                  :privilege, :grade, :accountbalance, :violationcount,
                  :deactivated, :school_memberships_attributes, :schools_attributes

  # accepts_nested_attributes_for :schools, allow_destroy: true
  accepts_nested_attributes_for :school_memberships, allow_destroy: true
  accepts_nested_attributes_for :schools, allow_destroy: true
   
	validates :username, :uniqueness => { :message => " already exists."}, :allow_blank => true
  validates :firstname, :presence=>true
  validates :lastname, :presence=>true
  validates_associated :schools
	
  # destroy any school memberships (and resulting orphan schools) before destroying the user account
  before_destroy :pre_delete_school_memberships
  
  def pre_delete_school_memberships
    sch_mbrships = self.school_memberships
    sch_mbrships.each do |m|
      m.destroy
    end
  end
end
