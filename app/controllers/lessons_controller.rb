class LessonsController < ApplicationController
  
  # GET /lessons
  # GET /lessons.json
  def index
    
    if current_user.class.to_s == "Instructor"
      @user = current_instructor
      @choices = @user.courses.where(:archived => 0)
    elsif current_user.class.to_s == "Student"
      @user = current_student
      @choices = @user.subjects.where(:archived => 0)
    else
      @user = current_parent
      # to_be_completed
    end
    
    @textbook = Textbook.find_by_id(params[:textbook_id])
    
    if params[:assetable]
      @assetable = @choices.find_by_id(params[:assetable][:id])
      @course_asset = @assetable.course_assets.try(:first)
      if @course_asset
        redirect_to send("course_asset_#{CourseAssetModelType.find_by_id(@course_asset.model_type).name_of_model}_path", @course_asset)
      else
        redirect_to polymorphic_path(@assetable)
      end
    
    elsif params[:filters]
      @course_asset = CourseAsset.find_by_id(params[:filters][:course_asset_id])
      @assetable = @course_asset.assetable
      @course_assets = @assetable.course_assets.order(:position)
      
      if (params[:commit] != "Reset")
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

    else
      @lessons = @textbook.lessons.sort{|a,b| a.page.to_i <=> b.page.to_i}
      @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
      @assetable = @course_asset.assetable
      @course_assets = @assetable.course_assets.order(:position)
      
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
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @lesson = Lesson.new
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @textbook = Textbook.find_by_id(params[:lesson][:textbook_id])
    @course_asset = CourseAsset.find_by_id(params[:lesson][:course_asset_id])
    if params[:commit]  != "Cancel"
      @filterstring = nil
      @lesson = Lesson.new(:title => params[:lesson][:title], :page => params[:lesson][:page], 
                           :textbook_id => @textbook.id, :instructor_id => current_instructor.id)
      if @lesson.save
        @ujsAlert = nil
        @ujsNotice = "Successfully created lesson."
      else  
        @ujsNotice = nil
        @ujsAlert = "Error! " + @lesson.errors.full_messages.first
        render "new"
      end
      @lessons = @textbook.lessons.sort{|a,b| a.page.to_i <=> b.page.to_i}
    else
      @ujsNotice = "Add new lesson action canceled."
      render "cancel"
    end
	end

  # GET /lessons/1/edit
  def edit
    @textbook = Textbook.find(params[:textbook_id])
    @lesson = Lesson.find(params[:id])
    @lessons = @textbook.lessons
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
  end

  # PUT /lessons/1
  # PUT /lessons/1.json
  def update
    @lesson = Lesson.find_by_id(params[:id])
    if params[:commit]  != "Cancel"
      if @lesson.update_attributes(:title => params[:lesson][:title], :page => params[:lesson][:page])
        @course_asset = CourseAsset.find_by_id(params[:lesson][:course_asset_id])
        @ujsAlert = nil
        @ujsNotice = "Successfully updated lesson."
      else  
        @ujsNotice = nil
        @ujsAlert = "Error! " + @lesson.errors.full_messages.first
        @course_asset = CourseAsset.find_by_id(params[:lesson][:course_asset_id])
        render "edit"
      end
    else
      @ujsNotice = "Update lesson action canceled."
      @course_asset = CourseAsset.find_by_id(params[:lesson][:course_asset_id])
    end
    @textbook = @lesson.textbook
    @lessons = @textbook.lessons.sort{|a,b| a.page.to_i <=> b.page.to_i}
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson = Lesson.find(params[:id])
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @textbook = @lesson.textbook
    @lesson.destroy
    @lessons = @textbook.lessons.sort{|a,b| a.page.to_i <=> b.page.to_i}
    @ujsAlert = nil
    @ujsNotice = "Lesson has been successfully deleted."
  end
  
end
