class SubjectsController < ApplicationController

  def index
    @student = Student.find_by_id(params[:student_id]) || current_student
    @subjects = @student.subjects
    @current_subjects = @student.subjects.where(:archived => false)
    @archived_subjects = @student.subjects.where(:archived => true)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @courses }
    end
  		
  end

  def show
    @student = Student.find_by_id(params[:student_id]) || current_student
    @subjects = @student.subjects.where(:archived => false)
    if params[:subject]
      @subject = Subject.where(:student_id => @student).find(params[:subject][:id])
    else
      @subject = Subject.where(:student_id => @student).find(params[:id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subject }
    end

  end

  def new
  	@subject = Subject.new
  	@new_category = false
  end

  def create
    @student = current_student or Student.find(params[:student_id])

    if params[:commit] == "Cancel"
      @action = "Create"
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
      @subject = @student.subjects.build(params[:subject])
      @subject.save
      
    else  # params[:commit] == "No"
      render('edit')
    end
     
  end 
  
  def edit
  	@subject = Subject.find(params[:id])
  	@new_category = false
  end

  def update
    @student = current_student or Student.find(params[:student_id])
    @subject = Subject.find(params[:id])
    
    if params[:commit] == "Cancel"       # form submitted to cancel the edit
      @action = "Edit"
      render('cancel')
      
    elsif params[:commit] == "Update"          # form submitted for traditional update
      @subject.assign_attributes(params[:subject])
      @category = @subject.category
      if @category && @category.new_record?
        @new_category = true;
        render('edit')
      else
        @subject.save
      end

    elsif params[:commit] == "Yes"
      @subject.update_attributes(params[:subject])
      
    elsif params[:commit] == "No"
      render('edit')
 
    else                                    # form was submitted via jquery to toggle archive
      @subject.update_attributes!(params[:subject])
      render('toggle_archive')
    end
    
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
  end
end
