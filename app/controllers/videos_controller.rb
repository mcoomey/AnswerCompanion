class VideosController < ApplicationController
    
  before_filter :load_videos
  
  # GET /videos
  # GET /videos.json
  def index
    respond_to do |format|
      format.html {
        flash[:alert] = "No videos found." if (@videos.count == 0)
        @videos_current = @videos.where(archived:0).where("old_version_id IS NULL").order("position")
        @videos_archived = @videos.where(archived:1).where("old_version_id IS NULL").order("position")
        @videos_future = @videos.where(archived:2).where("old_version_id IS NULL").order("position")
        render "index"
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
    @video = @course_asset.videos.new
  end

  def replace
    @old_version_id = params[:id]
    @video = @course_asset.videos.new
  end
  
  # POST /videos
  # POST /videos.json
  def create
   	if params[:commit]  == "Cancel"
      if params[:video][:replace_flag]
        @videoNotice = "Replace video action canceled."
      else
        @videoNotice = "Add new video action canceled."
      end
      render "cancel"
      
    elsif params[:video][:replace_flag]
      # find the original video that is being replaced
      @video = Video.find_by_id(params[:video][:old_version_id])
      
      # delete all the files in the associated directory
      FileUtils.rm_rf(Dir.glob(File.join(@video.videofile.root, @video.videofile.store_dir, '*')))
      
      # build a new video from the new videofile 
      @new_video = @course_asset.videos.build(params[:video])
      
      # copy new videofile into original video and clear videofile_processed flag
      @video.videofile = @new_video.videofile
      @video.get_video_duration
      @video.videofile_processed = 0
      
      # save the new version ans submit for processing
      if @video.save
        @videoError = nil
        @videoNotice = "Video replacement has been submitted for processing."
        @video.do_video_conversion
        render "update_replacement"
        
      else
        @videoNotice = nil
        @videoError = "Error! " + @video.errors.full_messages.first
        @old_version_id = params[:id]
        @video = @course_asset.videos.new
        render "replace"
      end

    # else create a brand new video
    else
      @video = @course_asset.videos.build(params[:video].merge({:instructor_id => current_instructor.id}))
      @video.position = Video.all.count + 1
      @action = "Create"
      if @video.save
        @videoError = nil
        @videoNotice = "Video upload has been submitted for processing."
        @video.do_video_conversion
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
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    @video = Video.find_by_id(params[:id])

   	if params[:commit]  == "Cancel"
      @videoNotice = "Edit video action canceled."
      render "cancel"
      
    elsif params[:archived]
      @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
      posit = @course_asset.videos.where(:archived=>params[:archived]).count + 1
      @video.archived = params[:archived]
      @video.position = posit
      if @video.save
        puts ">>>>>>>>>>>saved @video<<<<<<<<<"
      else
        puts ">>>>>>>>>>>failed to save @video<<<<<<<<<"
      end
      render nothing: true
      
    else
      @course_asset = CourseAsset.find_by_id(params[:video][:course_asset_id])
      @video.update_attributes(:title => params[:video][:title], :description => params[:video][:description])
      if @video.save
        @videoError = nil
        @videoNotice = "Successfully edited video."
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
  
  def load_videos
    
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id]) || CourseAsset.find_by_id(params[:video][:course_asset_id])
    @course = @course_asset.course
    @course_assets = @course.course_assets.order(:position)
    @instructor = @course.instructor
    @courses = @instructor.courses
    @videos = @course_asset.videos
    
  end
end
