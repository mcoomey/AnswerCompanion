class LinksController < ApplicationController
  def index
    @instructor = current_instructor
    @courses = @instructor.courses.where(:archived => 0)
    if params[:course]
      @course = Course.find_by_id(params[:course][:id])
      @course_asset = @course.course_assets.try(:first)
      if @course_asset
        redirect_to course_asset_links_path(@course_asset)
      else
        redirect_to course_path(@course)
      end
    else
      @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
      @course = @course_asset.course
    end
    @course_assets = @course.course_assets.order(:position)
    @links = @course_asset.try(:links)

		if @links
  		@links_current  = @links.where(:archived => 0).order("position")
  		@links_archived = @links.where(:archived => 1).order("position")
  		@links_future   = @links.where(:archived => 2).order("position")
		end
    
		if (@links && @links.count == 0)
			flash[:alert] = "There currently are not any links."
		else
			flash[:alert] = nil
		end
  end

  def show
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
      @link.save
      render "create"
    else
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
      render nothing: true
    
    elsif params[:commit]  != "Cancel"
      @link.description = params[:link][:description]
      @link.url = params[:link][:url]
      @link.save
      
    else
      render "cancel"
    end
    
  end

  def destroy
  end

  def sort
  end
end
