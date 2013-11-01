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
      @current_courses = @instructor.courses.where(:archived => false)
      @archived_courses = @instructor.courses.where(:archived => true)
    else
      @courses = Course.all
      @current_courses = Course.where(:archived => false)
      @archived_courses = Course.where(:archived => true)
    end

    respond_to do |format|
      format.html { # index.html.erb
        if @courses.count == 0
          flash[:notice] = "You don't have any courses defined.  "
          flash[:alert] = "Please add a course."
        end
        }
      format.json { render json: @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>params = " + params.inspect
    if params[:course]
      @course = Course.find_by_id(params[:course][:id])
      @course_asset = @course.course_assets.try(:first)
      if @course_asset
        redirect_to course_asset_textbook_delegations_path(@course_asset)
      else
  			flash[:alert] = "You must add a Course Asset."
        redirect_to course_path(@course)
      end
    else
      @course = Course.find_by_id(params[:id])
      @course_assets = @course.course_assets.roots
      if @course_assets.count == 0
  			flash[:alert] = "You must add a Course Asset."
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
    @instructor = Instructor.find_by_id(params[:instructor_id]) || current_instructor
    @course = @instructor.courses.build(params[:course])
   	if params[:commit]  != "Cancel"
    	@course.save
      render "create"
    else
      @action = "Create"
      render "cancel"
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find_by_id(params[:id])
    @instructor = @course.instructor
    if params[:commit] != "Cancel"
      @course.update_attributes(params[:course])
      render "update"
    else
      @action = "Edit"
      render "cancel"
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find_by_id(params[:id])
    @course.destroy
  end

  def toggle_archive
    @course = Course.find_by_id(params[:course_id])
    @course.update_attributes!(params[:course])
  end
end
