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
    # @schools = resource.schools
    @school = resource.schools.first
    @new_school = false
    puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ ABOUT TO RENDER EDIT VIEW @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
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
    
    # load the resource (i.e. Instructor, Student, Parent) from the db
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)
  
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
        msg ="Errors: " + resource.errors.full_messages.join(", ")
        @ujsAlert = msg
        puts "*******************#{msg}*******************"
      else
        msg = "Error: " + resource.errors.full_messages.join(", ")
        @ujsAlert = msg
        puts "*******************#{msg}*******************"
      end
      clean_up_passwords resource
      render :edit
    end
  end
  
  def encode_state_id(hash)
    state_id_hash = Hash.new
    change_state_key_and_value(hash, state_id_hash)
    state_id_hash
  end

  # change_state_key_and_value copies hash to target replacing state_abbrev keys and values with state_id
  def change_state_key_and_value(hash, target)

    hash.each do |k, v|
      if v.is_a?(String)
        if k=="state_abbrev"
          target["state_id"] = (State.find_by_abbrev(v).try(:id)).try(:to_s)
        else
          target[k] = v
        end
      elsif v.is_a?(Hash)
        target[k] = change_state_key_and_value(v, Hash.new)
      end
    end
    target
  end

end