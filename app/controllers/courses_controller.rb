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
    if params[:course]
      @course = Course.find_by_id(params[:course][:id])
    else
      @course = Course.find_by_id(params[:id])
    end
    @instructor = @course.instructor
    @courses = @instructor.courses.where(:archived => false)
    @selections = @courses.map{|x| [x.name + (x.section ? "-"+x.section : "") , x.id]}

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course }
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
      render "cancel"
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find(params[:id])
    @instructor = @course.instructor
    @course.update_attributes!(params[:course])
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
  end

end
