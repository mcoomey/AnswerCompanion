class ScreensController < ApplicationController
	
  respond_to :js, :html, :xml
  
  def index
    if params["msg"] == "DeletedAccount"
      @ujsNotice = "Account has been deleted.  We hope to see you again."
    end
    
    if current_student
      cookies.permanent[:user_mode] = :student
      redirect_to(student_subjects_path(current_student))
    elsif current_instructor
      cookies.permanent[:user_mode] = :instructor
      redirect_to(instructor_courses_path(current_instructor))
    elsif current_parent
      cookies.permanent[:user_mode] = :parent
      redirect_to(students_path)
    end  		
  end
  
end
