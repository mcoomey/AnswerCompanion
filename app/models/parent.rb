class Parent < ActiveRecord::Base
  
	has_many :role_assignments, :as => :roleable
	has_many :roles, :through => :role_assignments
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,  :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :firstname, :lastname, :username, :emailpref, :paypalaccount,
                  :privilege, :grade, :school, :accountbalance, :violationcount
   
	validates :username, :uniqueness => { :message => " already exists."}, :allow_blank => true
end
