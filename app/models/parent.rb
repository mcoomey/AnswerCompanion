class Parent < ActiveRecord::Base
  
	has_many :role_assignments, :as => :roleable
	has_many :roles, :through => :role_assignments
	has_many :family_memberships, :as => :familymember
	has_many :children, :through => :family_memberships, :source => :student
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,  :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :firstname, :lastname, :screenname, :emailpref, :paypalaccount,
                  :privilege, :grade, :school, :accountbalance, :violationcount
   

end
