class CoursesController < ApplicationController
  
  # before_filter :authenticate_instructor!  
  # load_and_authorize_resource :instructor
  # load_and_authorize_resource :course, :through => :instructor

  # GET /courses
  # GET /courses.json
  def index
    if params[:instructor_id]
      @instructor = Instructor.find_by_id(params[:instructor_id])
      @courses = @instructor.courses
      @current_courses = @instructor.courses.where(:archived => 0).order(:position)
      @archived_courses = @instructor.courses.where(:archived => 1).order(:position)
      @future_courses = @instructor.courses.where(:archived => 2).order(:position)
    else
      @courses = Course.all
      @current_courses = Course.where(:archived => 0).order(:position)
      @archived_courses = Course.where(:archived => 1).order(:position)
      @future_courses = Course.where(:archived => 2).order(:position)
    end

    respond_to do |format|
      format.html { # index.html.erb
        if @courses.count == 0
          @ujsNotice = "You don't have any courses defined.  "
          @ujsAlert = "Please add a course."
        end
        }
      format.json { render json: @courses }
      format.xml { render xml: @courses}
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    if params[:course]
      @course = Course.find_by_id(params[:course][:id])
      @course_asset = @course.course_assets.try(:first)
      if @course_asset
        redirect_to send("course_asset_#{CourseAssetModelType.find_by_id(@course_asset.model_type).name_of_model}_path", (@course_asset))
      else
  			@ujsAlert = "You must add a Course Asset."
        redirect_to course_path(@course)
      end
    else
      @course = Course.find_by_id(params[:id])
      @course_assets = @course.course_assets.order(:position)
      if @course_assets.count == 0
  			@ujsAlert = "You must add a Course Asset."
      end
      @instructor = @course.instructor
      @courses = @instructor.courses.where(:archived => false)
      
      @selections = @courses.map{|x| [x.name + (x.section ? "-"+x.section : "") , x.id]}

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @course }
      end
    end
  end

  # GET /courses/new
  # GET /courses/new.json
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find_by_id(params[:id])
    @instructor = @course.try(:instructor) || current_instructor
  end

  # POST /courses
  # POST /courses.json
  def create
    if params[:commit] == "Create"
      @instructor = Instructor.find_by_id(params[:instructor_id]) || current_instructor
      @course = @instructor.courses.build(params[:course])
      @course.archived = current_tab_index
      @course.position = @instructor.courses.where(:archived => current_tab_index).count + 1
      if @course.save
        @ujsNotice = "Course was successfully created."
        @ujsAlert = nil
        render "create"
      else
        @ujsNotice = nil
        @ujsAlert = @course.errors.full_messages.first
        render "new"
      end
    else
      @ujsNotice = "Create course action was canceled."
      render "cancel"
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
      
    @course = Course.find_by_id(params[:id])
    @instructor = @course.instructor
    
    if params[:archived]
      posit = @instructor.courses.where(:archived => params[:archived]).count + 1
      @course.archived = params[:archived]
      @course.position = posit
      @course.save
      @ujsNotice = "Course has been moved to #{current_drop_tab.to_s} tab."
      render "update"
      
    elsif params[:commit] && params[:commit] != "Cancel"
      if @course.update_attributes(params[:course])
        @ujsNotice = "Course was successfully updated."
        @ujsAlert = nil
        render "update"
      else
        @ujsNotice = nil
        @ujsAlert = @course.errors.full_messages.first
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
    @course = Course.find_by_id(params[:id])
    @course.destroy
    @ujsNotice = "Course was successfully deleted."
  end

  def sort
    courses = params[:course]
    idx = 1
    if courses && courses.count > 0
      courses.each do |courseid|
        course = Course.find_by_id(courseid)
        course.position = idx
        course.save
        idx = idx + 1
      end
    end
    render nothing: true
  end

end
