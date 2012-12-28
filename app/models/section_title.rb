class SectionTitle < ActiveRecord::Base
  belongs_to :textbook
  has_many :exercises

end
