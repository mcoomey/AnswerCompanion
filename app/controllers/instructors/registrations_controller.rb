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
    state = State.find_by_abbrev(params[resource_name][:school][:state_abbrev])
  
    @school = School.where(name: params[resource_name][:school][:name], 
                           town: params[resource_name][:school][:town], 
                           state_id: state).first_or_initialize
    build_resource(params[resource_name].except(:school))
    @role = Role.find_by_name("Instructor")
    resource.roles << @role
    resource.schools << @school

    # user clicked the "REGISTER" button
    if params["register"]
      # check to see if @school is valid or exists in db
      
      if (@school.new_record? && @school.valid? && resource.valid?)
        @new_school = true
        render :new
      else
        @new_school = false
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
    
    elsif params["commit"] == "Yes"
      @new_school = false
      @school.save
      if resource.save
        @ujsAlert = nil
        if resource.active_for_authentication?
          @ujsNotice = find_message(:"signed_up") if is_navigational_format?
          # set_flash_message :notice, :signed_up if is_navigational_format?
          sign_in(resource_name, resource)
          # respond_with resource, :location => after_sign_up_path_for(resource)
        else
          @ujsNotice = find_message(:"signed_up_but_#{resource.inactive_message}") #if is_navigational_format?
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
      
      
    else # params["commit"] == "No"
      @new_school = false
      render :new
    end
      
      
      
          
  end
  
  # GET /resource/edit
  def edit
    # @schools = resource.schools
    @school = resource.schools.first
    @new_school = false
    render :edit
  end
  
  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update

    # the delete method returns the value deleted or nil if nothing was deleted
    schools_attributes = params[resource_name].delete(:schools_attributes)
    
    # load the resource (i.e. Instructor, Student, Parent) from the db
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
  
    current_password = params[resource_name][:current_password]
    skool_error = false  
    
    
    if params["register"]

      if resource.valid_password?(current_password)
        if schools_attributes
          schools_attributes.each do | (key, val) |
            state_id = State.find_by_abbrev(val[:state_abbrev])
        
            skool = School.where(name: val[:name], town: val[:town], state_id: state_id).first_or_create
            if skool.errors.count == 0
              @school_error = false
              membership = SchoolMembership.where("school_id = ? and schoolmember_type = ? and schoolmember_id = ?", 
                                            skool.id, current_user.class.name, current_user.id).first
              if (val[:_destroy]=='1')
                membership.destroy
              elsif !membership
                resource.schools << skool
              end  
            else
              skool_error = true
              @school_error = true
            
              flash[:alert] = "School " + skool.errors.full_messages.first
            end
          end
        end
      end
    
      @schools = resource.schools

      if resource.update_with_password(params[resource_name])
        if is_navigational_format?
          flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ? :update_needs_confirmation : :updated
          set_flash_message :notice, flash_key unless skool_error
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

end