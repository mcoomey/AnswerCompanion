class SubjectsController < ApplicationController

  def index
    @student = Student.find(params[:student_id]) or current_student
    @subjects = @student.subjects
    @current_subjects = @student.subjects.where(:archived => false)
    @archived_subjects = @student.subjects.where(:archived => true)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  		
  end

  def show
  end

  def new
  	@subject = Subject.new
  end

  def create
    @student = current_student or Student.find(params[:instructor_id])
    @subject = @student.subjects.build(params[:subject])
   	if params[:commit]  != "Cancel"
    	@subject.save
      render "create"
    else
      render "cancel"
    end
  end

  def edit
  	@subject = Subject.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])
    @subject.update_attributes!(params[:subject])
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
  end
end
