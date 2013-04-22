class CoursesController < ApplicationController
  # GET /courses
  # GET /courses.json
  def index
    @instructor = current_instructor or Instructor.find(params[:instructor_id])
    @courses = @instructor.courses
    @current_courses = @instructor.courses.where(:archived => false)
    @archived_courses = @instructor.courses.where(:archived => true)

    respond_to do |format|
      format.html # index.html.erb
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

    respond_to do |format|
      format.html # new.html.erb
      format.js # new.js.erb
    end
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
    	if @course.save
    		flash[:notice] = "Successfully created course."
        respond_to do |format|
          format.html { redirect_to instructor_courses_path(:instructor_id => @course.instructor_id), notice: 'Course was successfully created.' }
          format.js
        end
      else
        respond_to do |format|
          format.html { 
            flash[:alert] = "Error! " + @course.errors.full_messages.first
            render action: "new"
          }
          format.js
        end
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.json
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to instructor_courses_path(:instructor_id => @course.instructor_id), notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to instructor_courses_path(:instructor_id => @course.instructor_id) + cookies[:course_index_tab] }
      format.js
    end
  end
end
