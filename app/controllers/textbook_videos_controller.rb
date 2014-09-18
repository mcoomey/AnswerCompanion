class TextbookVideosController < ApplicationController
  
  before_filter :load_videoable, :except => [:destroy]
  
  # GET /videos
  # GET /videos.json
  def index
    respond_to do |format|
      format.html {
        flash[:alert] = "No videos found."  if (@textbook_videos.count == 0)
        render :index
      }
      format.json { render json: @textbook_videos }
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = TextbookVideo.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/new
  # GET /videos/new.json
  def new
    @video = @videoable.textbook_videos.new
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
  end

  # POST /videos
  # POST /videos.json
  def create
    puts ">>>>>>>>>>Creating new Video with @videoable = #{@videoable}<<<<<<<<<<<<<<"
   	if params[:commit]  == "Cancel"
      @videoNotice = "Add new video action canceled."
      render "cancel"
    else
      @video = @videoable.textbook_videos.new(params[:textbook_video].except(:course_asset_id))
      if @video.save
        @videoError = nil
        @videoNotice = "Successfully added new video."
      else
        @videoNotice = nil
        @videoError = "Error! " + @video.errors.full_messages.first
        render "new"
      end
    end
  end

  # GET /videos/1/edit
  def edit
    @video = TextbookVideo.find_by_id(params[:id])
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])    
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    
   	if params[:commit]  == "Cancel"
      @videoNotice = "Edit video action canceled."
      render "cancel"
    else
      @new_video = TextbookVideo.new(params[:textbook_video].except(:course_asset_id))
      @course_asset = CourseAsset.find_by_id(params[:textbook_video][:course_asset_id])
      if @new_video.save
        @videoError = nil
        @videoNotice = "Successfully edited video."
        @old_video = TextbookVideo.find_by_id(params[:id])
        @old_video.destroy
      else
        @videoNotice = nil
        @videoError = "Error! " + @video.errors.full_messages.first
        render "edit"
      end
    end
  end

  
  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video = TextbookVideo.find(params[:id])
    @video.destroy
    @videoError = nil
    @videoNotice = "Video has been successfully deleted."
  end
 
  def sort
    if params[:video_id]
      params[:video_id].each_with_index do |id, index|
        Video.update_all({position: index+1}, {id: id})
      end
    end
    render nothing: true  
  end
    
  private
  
  def load_videoable
    @resource, id = request.path.split('/')[1,2]
    @videoable = @resource.singularize.classify.constantize.find_by_id(id)
    @textbook = @videoable.textbook
    if @resource == "textbook_videos"
      @textbook_videos = @textbook.textbook_videos
    else
      @textbook_videos = @videoable.textbook_videos
    end
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id]) || CourseAsset.find_by_id(params[:textbook_video][:course_asset_id])
    @course = @course_asset.course
    @course_assets = @course.course_assets.order(:position)
    @instructor = @course.instructor
    @courses = @instructor.courses    
  end
  
end
