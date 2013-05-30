class ScreensController < ApplicationController
	
  def index
    @video1 = Video.find(1)
    @video2 = Video.find(2)
    @video3 = Video.find(3)
    @video4 = Video.find(4)
  	if current_student
			  redirect_to(student_subjects_path(current_student))
  	elsif current_instructor
        redirect_to(instructor_courses_path(current_instructor))
		end  		
  end

  def welcome

  end  
    
end
