class EnrollmentsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @subject = Subject.find_by_id(params[:subject_id])
    @enrollment = @subject.build_enrollment
    
    @states = School.uniq.pluck(:state)
    @schools = School.all
    @instructors = Instructor.all
    @courses = Course.all
  end

  def create
    if !params[:commit] 
      
    elsif params[:commit]!= "Cancel"
    
    else
      @ujsNotice = "Enrollment in course canceled."
      render "cancel"  
    end
    
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
