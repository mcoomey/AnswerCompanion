class Enrollment < ActiveRecord::Base
  belongs_to :subject
  belongs_to :course
end
