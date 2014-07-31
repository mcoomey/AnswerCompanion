class VideosController < ApplicationController
  
  before_filter :load_videoable, :except => [:destroy]
  
  # GET /videos
  # GET /videos.json
  def index
    puts ">>>>>>>>>>@videos.count = #{@videos.count}<<<<<<<<<<<<<<<<<"
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @course = @course_asset.course
    @course_assets = @course.course_assets.order(:position)
    
    respond_to do |format|
      format.html {
        if (@videos.count == 0)
          flash[:alert] = "No videos found."
        end
    
        
        if ((@resource == "exercises")||(@resource == "lessons"))
          render "textbook_video_index"
        else
          @videos_current = @videos.where(archived:0).order("position")
          @videos_archived = @videos.where(archived:1).order("position")
          @videos_future = @videos.where(archived:2).order("position")
          render "index"
        end
      }
      format.json { render json: @videos }
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
    puts ">>>>>>>>>>Creating new Video with @videoable = #{@videoable}<<<<<<<<<<<<<<"
   	if params[:commit]  == "Cancel"
      @videoNotice = "Add new video action canceled."
      render "cancel"
    else
      params[:video].merge!({:instructor_id => @instructor.id})
      puts ">>>>>>>>>>>>params[:video] = #{params[:video]}<<<<<<<<<<<<<<<"
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
    @video = Video.find_by_id(params[:id])
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    @video = Video.find_by_id(params[:id])
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])

    if params[:archived]
      posit = @course_asset.videos.where(:archived=>params[:archived]).count + 1
      puts ">>>>>>>>params[:archived] = #{params[:archived]}<<<<<<<<<<<<<<"
      
      @video.archived = params[:archived]
      puts ">>>>>>>>@video.archived = #{@video.archived}<<<<<<<<<<<<<<"
      @video.position = posit
      puts ">>>>>>>>>>saving @video<<<<<<<<<<<<<<"
      if @video.save
        puts ">>>>>>>>>>>saved @video<<<<<<<<<"
      else
        puts ">>>>>>>>>>>failed to save @video<<<<<<<<<"
      end
      
      render nothing: true
    
    else 
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
  end
  
  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video = Video.find(params[:id])
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
    
    puts ">>>>>>>>>@resource = #{@resource}<<<<<<<<<<<<<<<"
    if @resource == "videos"
      @videos = Video.all
      @video = Video.find_by_id(params[:id])
    else
      @videoable = @resource.singularize.classify.constantize.find_by_id(id)
      @videos = @videoable.videos
      @course_asset = CourseAsset.find_by_id(params[:course_asset_id]) || CourseAsset.find_by_id(params[:video][:course_asset_id])
      @course = @course_asset.course
      @course_assets = @course.course_assets.order(:position)
      @instructor = @course.instructor
      @courses = @instructor.courses
      
      if (@resource == "exercises")||(@resource == "lessons")
        @textbook = @videoable.textbook
      end
    end
    
  end
  
end
