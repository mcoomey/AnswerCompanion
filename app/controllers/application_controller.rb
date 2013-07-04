class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to screens_index_path, :alert => "Unauthorized access. You have been redirected."
  end
  
  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
  
  
  def current_user
		(current_student || current_instructor || current_parent)
	end
	
	
end
