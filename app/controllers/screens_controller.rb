class ScreensController < ApplicationController
	
  def index
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
