class SubjectsController < ApplicationController

  before_filter :get_user_mode, :set_query_string

  def index
    @student = Student.find_by_id(params[:student_id])
    @subjects = @student.subjects
    @current_subjects = @subjects.where(:archived => 0).order(:position)
    @archived_subjects = @subjects.where(:archived => 1).order(:position)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @subjects }
      format.xml { render xml: @subjects }
    end
  		
  end

  def show
    
    if params[:subject]
      @subject = Subject.find_by_id(params[:subject][:id])
      @query_string = {:subject_id => @subject.id}
      @course_assets = @subject.course_assets
      @course_asset = @subject.course_assets.try(:first)
      if @course_asset
        redirect_to send("course_asset_#{CourseAssetModelType.find_by_id(@course_asset.model_type).name_of_model}_path", @course_asset, @query_string)
      else
        redirect_to subject_path(@subject, @query_string)
      end
    else
      @subject = Subject.find_by_id(params[:id])
      @course_assets = @subject.course_assets.order(:position)
      if @course_assets.count == 0
  			@ujsAlert = "You must add a Subject Asset or enroll in a course."
      end
      @student = @subject.student
      @subjects = @student.subjects.where(:archived => 0)
      
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @subject }
      end
    end
    
  end

  def new
  	@subject = Subject.new
  end

  def create
    
    if params[:commit] == "Create"
      @student = Student.find_by_id(params[:student_id]) || current_student
      @subject = @student.subjects.build(params[:subject])
      @subject.archived = current_tab_index
      @subject.position = @student.subjects.where(:archived => current_tab_index).count + 1
      if @subject.save
        @ujsNotice = "Subject was successfully created."
        @ujsAlert = nil
        render "create"
      else
        @ujsNotice = nil
        @ujsAlert = @subject.errors.full_messages.first
        render "new"
      end
    else
      @ujsNotice = "Create subject action was canceled."
      render "cancel"
    end
  end 
  
  
  def edit
  	@subject = Subject.find_by_id(params[:id])
  	@student = @subject.try(:student) || current_student
  end

  def update
    
    @subject = Subject.find_by_id(params[:id])
    @student = @subject.student
    
    if params[:archived]
      posit = @student.subjects.where(:archived => params[:archived]).count + 1
      @subject.archived = params[:archived]
      @subject.position = posit
      @subject.save
      @ujsNotice = "Subject has been moved to #{current_drop_tab.to_s} tab."
      render "update"
      
    elsif params[:commit] && params[:commit] != "Cancel"
      if @subject.update_attributes(params[:subject])
        @ujsNotice = "Subject was successfully updated."
        @ujsAlert = nil
        render "update"
      else
        @ujsNotice = nil
        @ujsAlert = @subject.errors.full_messages.first
        render "edit"
      end
    else
      @ujsNotice = "Update course action was canceled."
      @ujsAlert = nil
      render "cancel"
    end
 end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @subject = Subject.find_by_id(params[:id])
    @subject.destroy
    @ujsNotice = "Subject was successfully deleted."
  end
  
  def sort
    subjects = params[:subject]
    idx = 1
    if subjects && subjects.count > 0
      subjects.each do |subjectid|
        subject = Subject.find_by_id(subjectid)
        subject.position = idx
        subject.save
        idx = idx + 1
      end
    end
    render nothing: true
  end

  
  
end
