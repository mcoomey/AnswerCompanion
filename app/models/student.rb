class Student < ActiveRecord::Base
	
	has_many :role_assignments, :as => :roleable, dependent: :destroy
	has_many :roles, :through => :role_assignments
	has_many :school_memberships, :as => :schoolmember, dependent: :destroy
	has_many :schools, :through => :school_memberships
	has_many :subjects
	has_many :parent_emails, dependent: :destroy

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,  :lockable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
  								:firstname, :lastname, :username, :emailpref, :paypalaccount,
  								:privilege, :grade, :accountbalance, :violationcount, 
  								:schools_attributes, :parent_emails_attributes, :school_memberships_attributes,
                  :destroy_account

  accepts_nested_attributes_for :parent_emails, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :school_memberships, allow_destroy: true
   
  
	validates :username, :uniqueness => { :message => " already exists."}, :allow_blank => true
  validates_associated :schools
  validates_email_format_of :email, :message => 'is not a valid email format.'

  def destroy_account
    @destroy_account
  end

  def destroy_account=(val)
    @destroy_account = val
  end

end
