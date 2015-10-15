class Instructors::RegistrationsController < Devise::RegistrationsController

  before_filter :authenticate_instructor!
  
  respond_to :js, :html, :xml
  
  def new
    @school = School.new
    super    
  end

  def create
    
    @ujsAlert = nil
    @ujsNotice = nil
    @school_error = false
    state = State.find_by_abbrev(params[resource_name][:school][:state_abbrev])
    if !state
      @school_error = true
    end
  
    @school = School.where(name: params[resource_name][:school][:name], 
                           town: params[resource_name][:school][:town], 
                           state_id: state).first_or_initialize
    build_resource(params[resource_name].except(:school))
    @role = Role.find_by_name("Instructor")
    resource.roles << @role
    resource.schools << @school

      
    if resource.save
      if resource.active_for_authentication?
        @ujsNotice = find_message(:"signed_up") if is_navigational_format?
        # set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        # respond_with resource, :location => after_sign_up_path_for(resource)
      else
        @ujsNotice = find_message(:"signed_up_but_#{resource.inactive_message}") # if is_navigational_format?
        # set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        # respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      if resource.errors.count > 1
        @ujsAlert = "Errors: " + resource.errors.full_messages.join(", ")
      else
        @ujsAlert = "Error: " + resource.errors.full_messages.join(", ")
      end
      clean_up_passwords resource
      # respond_with resource
      render :new
    end
            
  end
  
  # GET /resource/edit
  def edit
    render :edit
  end
  
  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update

    # the delete method returns the value deleted or nil if nothing was deleted
    # current_password = params[resource_name].delete(:current_password)
    
    # update the params hash to replace state_abbrev with state_id 
    params[resource_name] = encode_state_id(params[resource_name])
    
    # isolate the school_memberships_attributes
    sma_params = params[resource_name].delete("school_memberships_attributes")
    
    # load the resource (i.e. Instructor, Student, Parent) from the db
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
  
    school_error_flag = false
    # check password and process the school memberships
    if resource.valid_password?(params[resource_name]["current_password"])
      sma_params.each do |k,v|
        if v.is_a?(Hash) && v.has_key?("school_attributes")
          # school_attributes is a hash representing a new school membership
          school = School.where(v["school_attributes"]).first_or_initialize
          if school.valid?
            if resource.schools.where(id:school.id).exists?
              @ujsNotice = @ujsNotice.to_s + "*** Duplicate school membership ignored. "
            else
              resource.schools << school
            end
          else
            school_error_flag = true
            @ujsAlert = @ujsAlert.to_s + school.errors.full_messages.join(", ")
          end
        elsif v.is_a?(Hash)
          # process existing SchoolMemberships
          if v["_destroy"] == "1"
            school_membership = SchoolMembership.find_by_id(v["id"])
            school_membership.destroy if school_membership
          end
        end
      end
    end
    
    if school_error_flag
      render :edit
      
    elsif ((resource.valid_password?(params[resource_name]["current_password"]))&&(params[resource_name]["destroy_account"]=="true"))
      sign_out @instructor
      if @instructor.destroy
        @instructor = nil
        redirect_to root_url+"?msg=DeletedAccount"
      else
        @ujsAlert = "Unable to delete account.  Please contact Customer Service."
      end
      
    elsif resource.update_with_password(params[resource_name])
      if is_navigational_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ? :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key unless skool_error
      end
      sign_in resource_name, resource, :bypass => true
      @ujsNotice = @ujsNotice.to_s + "Account has been updated. "
      respond_with resource, :location => after_update_path_for(resource)
    else
      if resource.errors.count > 1
        msg ="Errors: " + resource.errors.full_messages.join(", ")
        @ujsAlert = msg
      else
        msg = "Error: " + resource.errors.full_messages.join(", ")
        @ujsAlert = msg
      end
      clean_up_passwords resource
      render :edit
    end
  end

end