class CustomFailure < Devise::FailureApp
  def redirect_url
    if warden_options[:scope] == :instructor
      new_instructor_session_path
    elsif warden_options[:scope] == :student
      new_student_session_path
    elsif warden_options[:scope] == :parent
      new_parent_session_path
   end
  end
  
  
  def respond
    if http_auth?
      http_auth
    else
      store_location!
      flash[:alert] = i18n_message unless flash[:notice]  
      redirect_to redirect_url
    end
  end
end