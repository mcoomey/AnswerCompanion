class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.json
  def index
    @instructor = Instructor.find(params[:instructor_id]) or current_instructor
    @courses = @instructor.courses
    @current_courses = @instructor.courses.where(:archived => false)
    @archived_courses = @instructor.courses.where(:archived => true)

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
    @instructor = Instructor.find(params[:instructor_id])
    @courses = @instructor.courses.where(:archived => false)
    @selections = @courses.map{|x| [x.name + (x.section ? "-"+x.section : "") , x.id]}
    if params[:course]
      @course = Course.where(:instructor_id => @instructor).find(params[:course][:id])
    else
      @course = Course.where(:instructor_id => @instructor).find(params[:id])
    end

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
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.json
  def create
    @instructor = current_instructor or Instructor.find(params[:instructor_id])
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
    @course.update_attributes!(params[:course])
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy
  end
end
