class LinksController < ApplicationController
  
  before_filter  :get_user_mode, :set_query_string
  
  def index
    
    get_drop_menu_data
    
    @links = @course_asset.try(:links)
    

		if @links
  		@links_current  = @links.where(:archived => 0).order("position")
  		@links_archived = @links.where(:archived => 1).order("position")
  		@links_future   = @links.where(:archived => 2).order("position")
  		if (@links && @links.count == 0)
  			@ujsAlert = "There currently are not any links."
  		else
  			@ujsAlert = nil
      end
    end
  end

  def show
    @link = Link.find_by_id(params[:id])    
    if @link.url.match(/^http/)
      @target_url = @link.url
    else
      @target_url = "http://"+@link.url
    end
    respond_to do |format|
      format.html { get_drop_menu_data }# show.html.erb
      format.json { render json: @link }
      format.js   { get_drop_menu_data } # show.js.erb
    end    
  end

  def new
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @link = Link.new
  end

  def edit
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @link = Link.find_by_id(params[:id])
  end

  def create
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @link = @course_asset.links.build(params[:link])
    @link.position = @course_asset.links.where(:archived => current_tab_index).count + 1 
    @link.archived = current_tab_index
    @action = "Create"
    
   	if params[:commit]  != "Cancel"
      if @link.save
        @ujsAlert = nil
        @ujsNotice = "Successfully added link."
        render "create"
      else
        @ujsNotice = nil
        @ujsAlert = "Error! " + @link.errors.full_messages.first
        render "new"
      end
    else
      @ujsNotice = "Add new link action canceled."
      render "cancel"
    end
    
  end

  def update
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @link = Link.find_by_id(params[:id])
    @action = "Update"
    
    if params[:archived]
      posit = @course_asset.links.where(:archived=>params[:archived]).count + 1
      @link.archived = params[:archived]
      @link.position = posit
      @link.save
      @ujsNotice = "Link has been moved to #{current_drop_tab.to_s} tab."
      render "update"
    
    elsif params[:commit]  != "Cancel"
      @link.description = params[:link][:description]
      @link.url = params[:link][:url]
      if @link.save
        @ujsAlert = nil
        @ujsNotice = "Successfully added link."
        render "update"
      else
        @ujsNotice = nil
        @ujsAlert = "Error! " + @link.errors.full_messages.first
        render "new"
      end
      
    else
      @ujsNotice = "Update link action was canceled."
      @ujsAlert = nil
      render "cancel"
    end
    
  end

  def destroy
    @link = Link.find_by_id(params[:id])
    @link.destroy
    @ujsNotice = "Link was successfully deleted."
  end

  def sort
    if params[:link_id]
      params[:link_id].each_with_index do |id, index|
        Link.update_all({position: index+1}, {id: id})
      end
    end
    render nothing: true  
  end
  
  private
  
end
