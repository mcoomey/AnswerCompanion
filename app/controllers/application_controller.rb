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
	
  def current_horizontal_tab
	  selected = cookies[:horizontal_tabs_index][1..-1] #remove first character (. or #)
	  if selected == "current-tab"
	    return :Current
    elsif selected == "archived-tab"
      return :Archived
    elsif selected == "future-tab"
      return :Future
    else
      return nil
    end
  end

  def current_drop_tab
	  selected = cookies[:dropTab][1..-1] #remove first character (. or #)
	  if selected == "current-tab"
	    return :Current
    elsif selected == "archived-tab"
      return :Archived
    elsif selected == "future-tab"
      return :Future
    else
      return :Unknown
    end
  end

  def current_tab_index
	  [:Current, :Archived, :Future].index(current_horizontal_tab())
  end
	
end
