class Parents::RegistrationsController < Devise::RegistrationsController

  before_filter :authenticate_parent!
  
  def new
    @school = School.new
    super    
  end

  def create
    build_resource(params[resource_name]) 
    @role = Role.find_by_name("Parent")
    
    if resource.save
      resource.roles << @role
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      if resource.errors.count > 1
        flash[:alert] = "Errors: " + resource.errors.full_messages.join(", ")
      else
        flash[:alert] = "Error: " + resource.errors.full_messages.join(", ")
      end
      clean_up_passwords resource
      respond_with resource
    end
  end
  
  # GET /resource/edit
  def edit
    @parentemail = ParentEmail.where(email: current_user.email)
    @children = []
    @parentemail.each do |pe|
      @children<< pe.student
    end
    render :edit
  end
  
  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    @parentemail = ParentEmail.where(email: current_user.email)
    @children = []
    @parentemail.each do |pe|
      @children<< pe.student
    end
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
  
   if resource.update_with_password(params[resource_name])
      if is_navigational_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, :bypass => true
      respond_with resource, :location => after_update_path_for(resource)
    else
        if resource.errors.count > 1
          flash[:alert] = "Errors: " + resource.errors.full_messages.join(", ")
        else
          flash[:alert] = "Error: " + resource.errors.full_messages.join(", ")
        end
      clean_up_passwords resource
      respond_with resource
    end
  end

 
end