class Instructors::RegistrationsController < Devise::RegistrationsController
  
  def new
    @school = School.new
    super    
  end

  def create
    build_resource(params[:instructor].except(:school))
    @school = School.where(name: params[:instructor][:school][:name], 
                           town: params[:instructor][:school][:town], 
                           state: params[:instructor][:school][:state]).first_or_create
    
    if resource.save
      resource.schools << @school
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
      clean_up_passwords resource
      respond_with resource
    end
  end
end