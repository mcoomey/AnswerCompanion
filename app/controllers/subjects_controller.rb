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
  	@new_category = false
  	@confirmed_new_category = false
  end

  def create

    @student = current_student or Student.find(params[:student_id])
    
    if params[:commit] == "Cancel"
      render "cancel"
      
    elsif params[:commit] == "Create"
      @subject = @student.subjects.build(params[:subject])
      @category = @subject.category
      if @category && @category.new_record?
        @new_category = true;
        render('new')
      else
        @subject.save
      end
      
    elsif params[:commit] == "Yes"
      @confirmed_new_category = true
      @subject = @student.subjects.build(params[:subject])
      @subject.save
      
    else  # params[:commit] == "No"
      render('edit')
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
