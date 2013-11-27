class ExercisesController < ApplicationController
  
  # GET /exercises
  # GET /exercises.json
  def index
    
    if params[:filters]
      @course_asset = CourseAsset.find_by_id(params[:filters][:course_asset_id])
    else
      @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    end
    @instructor = current_instructor
    @courses = @instructor.courses.where(:archived => false)
    @course = @course_asset.course
    @course_assets = @course.course_assets
    @textbook = Textbook.find_by_id(params[:textbook_id])
    
    if params[:filters] && (params[:commit] != "Reset")
      @filterstring = params[:filters][:pagefilter]
      if @filterstring.include?('-')
        range = @filterstring.split('-')
        @exercises = @textbook.exercises.where("page between ? and ?", range[0].to_i, range[1].to_i).sort{|a,b| a.page.to_i <=> b.page.to_i}
      else
        @exercises = @textbook.exercises.where("page = ?", @filterstring)
      end
        
    else
      @filterstring = nil
      @exercises = @textbook.exercises.sort{|a,b| a.page.to_i <=> b.page.to_i}
    end
    
    flash[:alert] = nil
    
    if (@exercises.count == 0)
      flash[:alert] = "No exercises found."
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @exercises }
    end
  end

  # GET /exercises/1
  # GET /exercises/1.json
  def show
    @exercise = Exercise.find_by_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @exercise }
    end
  end

  def new
    @textbook = Textbook.find_by_id(params[:textbook_id])
    @exercise = @textbook.exercises.new(params[:exercise])
    @new_section_title = false
  end

  # POST /exercises
  # POST /exercises.json
  def create
    @textbook = Textbook.find_by_id(params[:exercise][:textbook_id])
    
    if params[:commit]  == "Cancel"
      @exerciseNotice = "Add new exercise action canceled."
      render "cancel"
    
    elsif params[:commit] == "Create"
      @filterstring = nil
      @exercise = @textbook.exercises.build(:textbook_id => @textbook.id, :number => params[:exercise][:number], :page => params[:exercise][:page], 
                               :section_title_name => params[:exercise][:section_title_name], 
                               :instructor_id => current_instructor.id)
      @section_title = @exercise.section_title
      if @section_title && @section_title.new_record?
        @new_section_title = true;
        render "new"
      elsif @exercise.save
        @exerciseError = nil
         @exerciseNotice = "Successfully created exercise."
      else  
        @exerciseNotice = nil
        @exerciseError = "Error! " + @exercise.errors.full_messages.first
      end
      @exercises = @textbook.exercises.sort{|a,b| a.page.to_i <=> b.page.to_i}
      
    elsif params[:commit] == "Yes"
      @filterstring = nil
      @exercise = @textbook.exercises.build(:textbook_id => @textbook.id, :number => params[:exercise][:number], :page => params[:exercise][:page], 
                               :section_title_name => params[:exercise][:section_title_name], 
                               :instructor_id => current_instructor.id)
      if @exercise.save
        @exerciseError = nil
        @exerciseNotice = "Successfully created exercise."
      else  
        @exerciseNotice = nil
        @exerciseError = "Error! " + @exercise.errors.full_messages.first
      end
      @exercises = @textbook.exercises.sort{|a,b| a.page.to_i <=> b.page.to_i}
      
    
    else  # params[:commit] == "No"
      render('edit')
    end
   
  end


  # GET /exercises/1/edit
  def edit
    @textbook = Textbook.find(params[:textbook_id])
    @exercise = Exercise.find(params[:id])
    @exercises = @textbook.exercises
  end

  # PUT /exercises/1
  # PUT /exercises/1.json
  def update
    @exercise = Exercise.find(params[:id])
    if params[:commit]  != "Cancel"
      if @exercise.update_attributes(:title => params[:exercise][:title], :page => params[:exercise][:page])
        @exerciseError = nil
        @exerciseNotice = "Successfully updated exercise."
      else  
        @exerciseNotice = nil
        @exerciseError = "Error! " + @exercise.errors.full_messages.first
        render "edit"
      end
    else
      @exerciseNotice = "Update exercise action canceled."
    end
    @textbook = @exercise.textbook
    @exercises = @textbook.exercises.sort{|a,b| a.page.to_i <=> b.page.to_i}
  end

  # DELETE /exercises/1
  # DELETE /exercises/1.json
  def destroy
    @exercise = Exercise.find(params[:id])
    @textbook = @exercise.textbook
    @exercise.destroy
    @exercises = @textbook.exercises.sort{|a,b| a.page.to_i <=> b.page.to_i}
    @exerciseError = nil
    @exerciseNotice = "Exercise has been successfully deleted."
  end

end
