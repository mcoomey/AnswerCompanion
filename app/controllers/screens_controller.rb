class ScreensController < ApplicationController
	
  def index
    flash.keep(:alert)
    flash.keep(:notice)
  	if current_student
			  redirect_to(student_subjects_path(current_student))
  	elsif current_instructor
        redirect_to(instructor_courses_path(current_instructor))
		end  		
  end

end
