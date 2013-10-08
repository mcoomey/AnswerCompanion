class Instructor < ActiveRecord::Base
	
	has_many :role_assignments, :as => :roleable
	has_many :roles, :through => :role_assignments
	has_many :school_memberships, :as => :schoolmember
	has_many :schools, :through => :school_memberships
	has_many :courses, dependent: :destroy
	has_many :videos
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
                  :deactivated, :school, :schools_attributes
  accepts_nested_attributes_for :schools, allow_destroy: true
   
	validates :username, :uniqueness => { :message => " already exists."}, :allow_blank => true
	
end
