class CustomFailure < Devise::FailureApp
  def redirect_url
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> warden_options[:scope] = #{warden_options[:scope]} <<<<<<<<<<<<<<<<<<<"
    if warden_options[:scope] == :instructor
      puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> #{new_instructor_session_path} <<<<<<<<<<<<<<<<<<<<<<<<"
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
      redirect_to redirect_url, remote: true
    end
  end
end