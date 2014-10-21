class TextboxesController < ApplicationController
  # GET /textboxes
  # GET /textboxes.json
  def index
    
    @instructor = current_instructor
    @courses = @instructor.courses.where(:archived => 0)
    if params[:course]
      @course = Course.find_by_id(params[:course][:id])
      @course_asset = @course.course_assets.try(:first)
      if @course_asset
        redirect_to course_asset_textbook_delegations_path(@course_asset)
      else
        redirect_to course_path(@course)
      end
    else
      @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
      @course = @course_asset.course
    end
    @course_assets = @course.course_assets.order(:position)
    @textboxes = @course_asset.try(:textboxes)

		if @textboxes
  		@textboxes_current  = @textboxes.where(:archived => 0).order("position DESC")
  		@textboxes_archived = @textboxes.where(:archived => 1).order("position DESC")
  		@textboxes_future   = @textboxes.where(:archived => 2).order("position DESC")
		end
    
		if (@textboxes && @textboxes.count == 0)
			flash[:alert] = "There currently are not any textboxes."
		else
			flash[:alert] = nil
		end
  end

  # GET /textboxes/1
  # GET /textboxes/1.json
  def show
    @textbox = Textbox.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @textbox }
    end
  end

  # GET /textboxes/new
  # GET /textboxes/new.json
  def new
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @textbox = Textbox.new
  end

  # GET /textboxes/1/edit
  def edit
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @textbox = Textbox.find(params[:id])
  end

  # POST /textboxes
  # POST /textboxes.json
  def create
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @textbox = @course_asset.textboxes.build(params[:textbox])
    @textbox.archived = current_tab_index
    @textbox.position = Textbox.all.count + 1
   	if params[:commit]  != "Cancel"
    	@textbox.save
      render "create"
    else
      @action = "Create"
      render "cancel"
    end
  end

  # PUT /textboxes/1
  # PUT /textboxes/1.json
	def update
    @textbox = Textbox.find_by_id(params[:id])
    
    if params[:archived]
      posit = @textbox.course_asset.textboxes.where(:archived=>params[:archived]).count + 1
      @textbox.archived = params[:archived]
      @textbox.position = posit
      @textbox.save
      render nothing: true
    elsif params[:commit] && params[:commit] != "Cancel"
      @textbox.update_attributes(params[:textbox])
      render "update"
    else
      @action = "Edit"
      render "cancel"
    end
    
    
	end
  

  # DELETE /textboxes/1
  # DELETE /textboxes/1.json
  def destroy
    @textbox = Textbox.find(params[:id])
    @textbox.destroy
  end
  
  
  def sort
    tboxes = params[:tbox_id]
    idx = 0
    if tboxes && tboxes.count > 0
      tboxes.each do |tbid|
        tbox = Textbox.find_by_id(tbid)
        tbox.position = tboxes.count - idx
        tbox.save
        idx = idx + 1
      end
    end      
    render nothing: true
  end
  
end
