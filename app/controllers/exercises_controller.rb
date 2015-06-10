class ExercisesController < ApplicationController
  
  before_filter :get_user_mode, :set_query_string, :load_query_string_vals
  
  def index
    
    get_drop_menu_data
       
    @textbook = Textbook.find_by_id(params[:textbook_id])
    
    if params[:filters]
      # @course_asset = CourseAsset.find_by_id(params[:filters][:course_asset_id])
      # @assetable = @course_asset.assetable
      # @course_assets = @assetable.course_assets.order(:position)
      
      if (params[:commit] != "Reset")
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

    else
      @exercises = @textbook.exercises.sort{|a,b| a.page.to_i <=> b.page.to_i}
      # @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
      # @assetable = @course_asset.assetable
      # @course_assets = @assetable.course_assets.order(:position)
      
    end
    
    @ujsAlert = nil
    
    if (@exercises.count == 0)
      @ujsAlert = "No exercises found."
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
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @exercise = @textbook.exercises.new(params[:exercise])
    @new_section_title = false
  end

  # POST /exercises
  # POST /exercises.json
  def create
    @textbook = Textbook.find_by_id(params[:exercise][:textbook_id])
    @course_asset = CourseAsset.find_by_id(params[:exercise][:course_asset_id])
    
    if params[:commit]  == "Cancel"
      @ujsNotice = "Add new exercise action canceled."
      render "cancel"
    
    elsif params[:commit] == "Create"
      @filterstring = nil
      @exercise = @textbook.exercises.build(:textbook_id => @textbook.id, :number => params[:exercise][:number], :page => params[:exercise][:page], 
                               :section_title_name => params[:exercise][:section_title_name], 
                               :instructor_id => current_instructor.id)
      @section_title = @exercise.section_title
      
      # check to see if section_title exists in db
      
      if @section_title && @section_title.new_record?
        @new_section_title = true;
        
        # render new view again with flag to confirm new_section creation
        render "new"
        
      elsif @exercise.save
        @exercises = @textbook.exercises.sort{|a,b| a.page.to_i <=> b.page.to_i}
        @ujsAlert = nil
        @ujsNotice = "Successfully created exercise."
        render "create"
      else  
        @ujsNotice = nil
        @ujsAlert = "Error! " + @exercise.errors.full_messages.first
        render "new"
      end      
      
    elsif params[:commit] == "Yes"
      @filterstring = nil
      @exercise = @textbook.exercises.build(:textbook_id => @textbook.id, :number => params[:exercise][:number], :page => params[:exercise][:page], 
                               :section_title_name => params[:exercise][:section_title_name], 
                               :instructor_id => current_instructor.id)
      if @exercise.save
        @exercises = @textbook.exercises.sort{|a,b| a.page.to_i <=> b.page.to_i}
        @ujsAlert = nil
        @ujsNotice = "Successfully created exercise."
        render "create"
      else  
        @ujsNotice = nil
        @ujsAlert = "Error! " + @exercise.errors.full_messages.first
        render "new"
      end
    
    else  # params[:commit] == "No"
      params[:exercise][:section_title_name] = ""
      @exercise = @textbook.exercises.new(params[:exercise].except(:course_asset_id))
      @new_section_title = false;
      @ujsNotice = "Please re-enter the section title."
      render('new')
    end
   
  end


  # GET /exercises/1/edit
  def edit
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @textbook = Textbook.find(params[:textbook_id])
    @exercise = Exercise.find(params[:id])
    @exercises = @textbook.exercises
  end

  # PUT /exercises/1
  # PUT /exercises/1.json
  def update
    @exercise = Exercise.find_by_id(params[:id])
    @textbook = @exercise.textbook
    @course_asset = CourseAsset.find_by_id(params[:exercise][:course_asset_id])
    
    if params[:commit]  == "Cancel"
      @ujsNotice = "Update exercise action canceled."
      @ujsAlert = nil
      render "cancel"
      
    elsif params[:commit] == "Update"
      old_section_title = @exercise.section_title
      @exercise.assign_attributes(params[:exercise].except(:course_asset_id, :course_id, :subject_id))
      @section_title = @exercise.section_title
      if @section_title && @section_title.new_record?
        @new_section_title = true;
        render "new"
      elsif @exercise.save
        if old_section_title.exercises.count == 0
          old_section_title.delete
        end
        @ujsAlert = nil
        @ujsNotice = "Successfully updated exercise."
        @exercises = @textbook.exercises.sort{|a,b| a.page.to_i <=> b.page.to_i}
        render "update"
      else  
        @ujsNotice = nil
        @ujsAlert = "Error! " + @exercise.errors.full_messages.first
        render "edit"
      end
      
    elsif params[:commit] == "Yes"
      @filterstring = nil
      @exercise.assign_attributes(params[:exercise].except(:course_asset_id))
      if @exercise.save
        @ujsAlert = nil
        @ujsNotice = "Successfully updated exercise."
        render "update"
      else  
        @ujsNotice = nil
        @ujsAlert = "Error! " + @exercise.errors.full_messages.first
        render "edit"
      end
    
    else  # params[:commit] == "No"
      @ujsNotice = "Please re-enter the section title."
      render('edit')
    end

    
  end

  # DELETE /exercises/1
  # DELETE /exercises/1.json
  def destroy
    @exercise = Exercise.find(params[:id])
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @textbook = @exercise.textbook
    @exercise.destroy
    @exercises = @textbook.exercises.sort{|a,b| a.page.to_i <=> b.page.to_i}
    @ujsAlert = nil
    @ujsNotice = "Exercise has been successfully deleted."
  end

end
