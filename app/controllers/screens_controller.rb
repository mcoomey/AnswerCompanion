class ScreensController < ApplicationController
	
  def index
  	if current_student
			  redirect_to(student_subjects_path(current_student))
  	elsif current_instructor
        redirect_to(instructor_courses_path(current_instructor))
		end  		
  end

  def welcome
    @user = Student.find_by_email(params[:student][:email]) if params[:student][:email]

    if @user
      if @user.valid_password?(params[:student][:passwd])
        @valid = true
      else
        @valid = false
      end
    end
  end  
    
end
