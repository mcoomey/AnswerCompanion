class EnrollmentsController < ApplicationController
  def index
  end

  def show
  end



  def new
    @subject = Subject.find_by_id(params[:subject_id])
    @enrollment = @subject.build_enrollment
    
    @school = current_student.schools.first
    @instructors = @school.instructors.order(:lastname)
    @courses = @school.courses
    if @courses.count == 0
      @ujsAlert = @school.name + " does not offer any courses at this time, but you may create your own."
    else
      @ujsAlert = nil
    end
  end
  
  

  def create
    if params[:commit] == "Enroll" 
      @instructor = Instructor.find_by_id(params["instructor"]["id"])
      @subject = Subject.find_by_id(params[:subject_id])
      @enrollment = Enrollment.new(course_id: params["enrollment"]["course_id"], subject_id: params["subject_id"], passphrase: params["enrollment"]["passphrase"])
      course = Course.find_by_id(params["enrollment"]["course_id"])
      if params["enrollment"]["passphrase"] != course.passphrase
        @ujsAlert = "Error! Incorrect Passphrase.  Please check with instructor."
        
        @school = current_student.schools.first
        @instructors = @school.instructors.order(:lastname)
        @courses = @school.courses
        
        render :new
        
      elsif @enrollment.save
        subject = Subject.find_by_id(params["subject_id"])
        
        # if enrolled course has any course assets set reload path to the first asset
        if subject.enrollment.course.course_assets.count > 0
          @reload_path = send("course_asset_#{CourseAssetModelType.find_by_id(subject.enrollment.course.course_assets.first.model_type).name_of_model}_path", 
                                              subject.enrollment.course.course_assets.first,
                                              subject_id: subject.id )
          
        # else if the subject has any local assets set reload path to the first one
        elsif subject.course_assets.count > 0
          @reload_path = send("course_asset_#{CourseAssetModelType.find_by_id(subject.course_assets.first.model_type).name_of_model}_path", 
                                              subject.course_assets.first,
                                              subject_id: subject.id )
          
        # otherwise set the reload path to the subject path (don't forget the query string subject_id=subject.id)
        else
          @reload_path = student_subject_path(current_student, subject.id, subject_id: subject.id)
          
        end
      
      else
        @ujsAlert = "Error: Unable to enroll in course.  Please file a bug report."
        @reload_path = student_subject_path(current_student, params["subject_id"])
      end
      
      puts "***** @reload_path = #{@reload_path} *****"
 
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
