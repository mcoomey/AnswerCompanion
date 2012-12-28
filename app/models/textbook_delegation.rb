class TextbookDelegation < ActiveRecord::Base
	belongs_to :subject
	belongs_to :textbook
	
	accepts_nested_attributes_for :subject
end
