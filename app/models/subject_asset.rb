class SubjectAsset < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :textbook_delegations, dependent: :destroy
  has_many :textbooks, :through => :textbook_delegations, dependent: :destroy
  has_many :videos
  has_many :documents
  has_many :links
  has_many :textboxes
  
  belongs_to :subject
  
end
