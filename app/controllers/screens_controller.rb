class ScreensController < ApplicationController
	
  def index
  	if current_student
  	  if current_student.subjects.count > 0
        redirect_to(subject_textbook_delegations_path(current_student.subjects.first.id))
			else
			  redirect_to(student_subjects_path(current_student))
			end
  	elsif current_instructor
      if current_instructor.courses.count > 0
        redirect_to(instructor_course_path(current_instructor.id, current_instructor.courses.first.id))
      else
        redirect_to(instructor_courses_path(current_instructor))
      end
		end  		
  end

  def welcome

  end  
    
end
