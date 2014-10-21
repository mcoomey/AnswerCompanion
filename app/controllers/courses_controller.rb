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
      @course_assets = @course.course_assets.order(:position)
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
    @course.archived = current_tab_index
    posit = @instructor.courses.where(:archived => current_tab_index).count + 1
    @course.position = posit
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
    puts params.inspect
      
    @course = Course.find_by_id(params[:id])
    @instructor = @course.instructor
    
    if params[:archived]
      posit = @instructor.courses.where(:archived => params[:archived]).count + 1
      @course.archived = params[:archived]
      @course.position = posit
      @course.save
    end
        
    if params[:commit] && params[:commit] != "Cancel"
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
