class PasswordsController < Devise::PasswordsController 

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(params[resource_name])
    if successfully_sent?(resource)
      respond_with({}, :location => root_path)
    else  
      devise_alert_messages!
      respond_with(resource)
    end
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(params[resource_name])

    if resource.errors.empty?
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message(:notice, flash_message) if is_navigational_format?
      # flash.keep
      sign_in(resource_name, resource)
      respond_with resource, :location => after_sign_in_path_for(resource)
    else
      devise_alert_messages!
      respond_with resource
    end
  end

  def devise_alert_messages!
    if resource.errors.empty?
      flash[:alert] = nil
    elsif resource.errors.count > 1
      flash[:alert] = "Errors: " + resource.errors.full_messages.join(", ")
    else
      flash[:alert] = "Error: " + resource.errors.full_messages.first
    end
  end
	

end