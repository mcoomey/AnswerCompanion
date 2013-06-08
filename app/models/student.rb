class Student < ActiveRecord::Base
	
	has_many :school_memberships, :as => :schoolmember
	has_many :schools, :through => :school_memberships
	has_many :subjects
	has_and_belongs_to_many :parents

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,  :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  								:firstname, :lastname, :screenname, :emailpref, :paypalaccount,
  								:role, :privilege, :grade, :school, :accountbalance, :violationcount

end
