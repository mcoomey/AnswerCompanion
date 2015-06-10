class TextboxesController < ApplicationController
  
  before_filter :get_user_mode, :set_query_string
  
  def index
    
    get_drop_menu_data
    
    # set sortable mode for instructors or students who own the asset
    set_sortable_mode
     
    @textboxes = @course_asset.try(:textboxes)

    respond_to do |format|
      format.html {
    		if @textboxes
      		@textboxes_current  = @textboxes.where(:archived => 0).order("position DESC")
      		@textboxes_archived = @textboxes.where(:archived => 1).order("position DESC")
      		@textboxes_future   = @textboxes.where(:archived => 2).order("position DESC")
      		if (@textboxes && @textboxes.count == 0)
      			@ujsAlert = "There currently are not any textboxes."
      		else
      			@ujsAlert = nil
      		end
    		end    
      }
      format.json {
        render json: @textboxes
      }
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
    @text_rows = "4"
  end

  # GET /textboxes/1/edit
  def edit
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @textbox = Textbox.find(params[:id])
    @text_rows = [@textbox.content.lines.count, 4].max.to_s
  end

  # POST /textboxes
  # POST /textboxes.json
  def create
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @textbox = @course_asset.textboxes.build(params[:textbox])
    @textbox.archived = current_tab_index
    @textbox.position = @course_asset.textboxes.where(:archived => current_tab_index).count + 1
    
   	if params[:commit]  != "Cancel"
    	if @textbox.save
        @ujsAlert = nil
        @ujsNotice = "Successfully added textbox."
        render "create"
      else
        @ujsNotice = nil
        @ujsAlert = "Error! " + @textbox.errors.full_messages.first
        render "new"
      end
    else
      @ujsNotice = "Add new textbox action canceled."
      @action = "Create"
      render "cancel"
    end
  end

  # PUT /textboxes/1
  # PUT /textboxes/1.json
	def update
    @textbox = Textbox.find_by_id(params[:id])
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    
    if params[:archived]
      posit = @course_asset.textboxes.where(:archived=>params[:archived]).count + 1
      @textbox.archived = params[:archived]
      @textbox.position = posit
      @textbox.save
      @ujsNotice = "Textbox has been moved to #{current_drop_tab.to_s} tab."
      render nothing: true  
    elsif params[:commit] && params[:commit] != "Cancel"
      if @textbox.update_attributes(params[:textbox])
        @ujsAlert = nil
        @ujsNotice = "Successfully updated textbox."
        render "update"
      else
        @ujsNotice = nil
        @ujsAlert = "Error! " + @textbox.errors.full_messages.first
        render "edit"
      end
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
    @ujsNotice = "Textbox was successfully deleted."
    
  end
  
  
  def sort
    if params[:tbox_id]
      params[:tbox_id].reverse.each_with_index do |id, index|
        Textbox.update_all({position: index+1}, {id: id})
      end
    end
    render nothing: true  
  end
  
  
end

