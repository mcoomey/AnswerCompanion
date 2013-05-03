class TextbookDelegation < ActiveRecord::Base
  belongs_to :textable, :polymorphic => true
	belongs_to :textbook
	
end
