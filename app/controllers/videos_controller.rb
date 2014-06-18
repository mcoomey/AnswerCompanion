class VideosController < ApplicationController
  
  before_filter :load_videoable, :except => [:destroy]
  
  # GET /videos
  # GET /videos.json
  def index
    
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @course = @course_asset.course
    @course_assets = @course.course_assets.order(:position)
    @videos = @course_asset.videos
    
    respond_to do |format|
      format.html {
        if ((@resource == "exercises")||(@resource == "lessons"))
          render "textbook_video_index"
        else
          @videos_current = @videos
          render "index"
        end
      }
      format.json { }
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = Video.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/new
  # GET /videos/new.json
  def new
    @video = @videoable.videos.new
  end

  # POST /videos
  # POST /videos.json
  def create
   	if params[:commit]  == "Cancel"
      @videoNotice = "Add new video action canceled."
      render "cancel"
    else
      @video = @videoable.videos.new(params[:video].except(:course_asset_id))
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
    @video = Video.find(params[:id])
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    @videoError = nil
    @videoNotice = "Video has been successfully deleted."
  end
 
  private
  
  def load_videoable
    @resource, id = request.path.split('/')[1,2]
    
    puts ">>>>>>>>>@resource = #{@resource}<<<<<<<<<<<<<<<"
    if @resource == "videos"
      @videos = Video.all
      @video = Video.find_by_id(params[:id])
    elsif (@resource == "exercises")||(@resource == "lessons")
      @videoable = @resource.singularize.classify.constantize.find_by_id(id)
      @textbook = @videoable.textbook
      @videos = @videoable.videos
      @course_asset = CourseAsset.find_by_id(params[:course_asset_id]) || CourseAsset.find_by_id(params[:video][:course_asset_id])
      @course = @course_asset.course
      @course_assets = @course.course_assets.order(:position)
      @instructor = @course.instructor
      @courses = @instructor.courses
    else
      @videoable = @resource.singularize.classify.constantize.find_by_id(id)
      @videos = @videoable.videos
      @course_asset = CourseAsset.find_by_id(params[:course_asset_id]) || CourseAsset.find_by_id(params[:video][:course_asset_id])
      @course = @course_asset.course
      @course_assets = @course.course_assets.order(:position)
      @instructor = @course.instructor
      @courses = @instructor.courses      
    end
  end
  
end
