class LessonsController < ApplicationController
  
  # GET /lessons
  # GET /lessons.json
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
        @lessons = @textbook.lessons.where("page between ? and ?", range[0].to_i, range[1].to_i).sort{|a,b| a.page.to_i <=> b.page.to_i}
      else
        @lessons = @textbook.lessons.where("page = ?", @filterstring)
      end
        
    else
      @filterstring = nil
      @lessons = @textbook.lessons.sort{|a,b| a.page.to_i <=> b.page.to_i}
    end
    
    flash[:alert] = nil
    
    if (@lessons.count == 0)
      flash[:alert] = "No lessons found."
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lessons }
    end    
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @lesson = Lesson.find_by_id(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lesson }
    end
  end

  def new
    @textbook = Textbook.find_by_id(params[:textbook_id])
    @lesson = Lesson.new
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @textbook = Textbook.find_by_id(params[:lesson][:textbook_id])
    if params[:commit]  != "Cancel"
      @filterstring = nil
      @lesson = Lesson.new(:title => params[:lesson][:title], :page => params[:lesson][:page], 
                           :textbook_id => @textbook.id, :instructor_id => current_instructor.id)
      if @lesson.save
        @lessonError = nil
        @lessonNotice = "Successfully created lesson."
      else  
        @lessonNotice = nil
        @lessonError = "Error! " + @lesson.errors.full_messages.first
      end
      @lessons = @textbook.lessons.sort{|a,b| a.page.to_i <=> b.page.to_i}
    else
      @lessonNotice = "Add new lesson action canceled."
      render "cancel"
    end
	end

  # GET /lessons/1/edit
  def edit
    @textbook = Textbook.find(params[:textbook_id])
    @lesson = Lesson.find(params[:id])
    @lessons = @textbook.lessons
  end

  # PUT /lessons/1
  # PUT /lessons/1.json
  def update
    @lesson = Lesson.find(params[:id])
    if params[:commit]  != "Cancel"
      if @lesson.update_attributes(:title => params[:lesson][:title], :page => params[:lesson][:page])
        @lessonError = nil
        @lessonNotice = "Successfully updated lesson."
      else  
        @lessonNotice = nil
        @lessonError = "Error! " + @lesson.errors.full_messages.first
        render "edit"
      end
    else
      @lessonNotice = "Update lesson action canceled."
    end
    @textbook = @lesson.textbook
    @lessons = @textbook.lessons.sort{|a,b| a.page.to_i <=> b.page.to_i}
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson = Lesson.find(params[:id])
    @textbook = @lesson.textbook
    @lesson.destroy
    @lessons = @textbook.lessons.sort{|a,b| a.page.to_i <=> b.page.to_i}
    @lessonError = nil
    @lessonNotice = "Lesson has been successfully deleted."
  end
  
end
