class TextbookVideosController < ApplicationController
  
  before_filter :load_videoable, :except => [:destroy]
  
  # GET /videos
  # GET /videos.json
  def index
    respond_to do |format|
      format.html {
        flash[:alert] = "No videos found."  if (@textbook_videos.count == 0)
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
  end
  
  def replace
    @old_version_id = params[:id]
    @video = @videoable.textbook_videos.new
  end

  # POST /videos
  # POST /videos.json
  
  def create
   	if params[:commit]  == "Cancel"
      if params[:textbook_video][:replace_flag]
        @ujsNotice = "Replace video action canceled."
      else
        @ujsNotice = "Add new video action canceled."
      end
      render "cancel"
      
    elsif params[:textbook_video][:replace_flag]
      # find the original video that is being replaced
      @video = TextbookVideo.find_by_id(params[:textbook_video][:old_version_id])
      
      # delete all the files in the associated directory
      FileUtils.rm_rf(Dir.glob(File.join(@video.videofile.root, @video.videofile.store_dir, '*')))
      
      # get @videoable from the old version
      @videoable = @video.videoable
      
      # build a new video from the new videofile 
      @new_video = @videoable.textbook_videos.new(params[:textbook_video].except(:course_asset_id))
      
      # copy new videofile into original video and clear videofile_processed flag
      @video.videofile = @new_video.videofile
      @video.get_video_duration
      @video.videofile_processed = 0
      
      # save the new version and submit for processing
      if @video.save
        @ujsAlert = nil
        @ujsNotice = "Video replacement has been submitted for processing."
        @video.do_video_conversion
        render "update_replacement"
        
      else
        @ujsNotice = nil
        @ujsAlert = "Error! " + @video.errors.full_messages.first
        @old_version_id = params[:id]
        @video = @course_asset.videos.new
        render "replace"
      end

    # else create a brand new video
    else
      @video = @videoable.textbook_videos.new(params[:textbook_video].except(:course_asset_id))
      @action = "Create"
      if @video.save
        @ujsAlert = nil
        @ujsNotice = "Video upload has been submitted for processing."
        @video.do_video_conversion
      else
        @ujsNotice = nil
        @ujsAlert = "Error! " + @video.errors.full_messages.first
        render "new"
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video = TextbookVideo.find(params[:id])
    @video.destroy
    @ujsAlert = nil
    @ujsNotice = "Video has been successfully deleted."
  end
 
  private
  
  def load_videoable
    @resource, id = request.path.split('/')[1,2]
    @videoable = @resource.singularize.classify.constantize.find_by_id(id)
    if @videoable
      @textbook = @videoable.textbook
      @textbook_videos = @videoable.textbook_videos
    end
    
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
    
    
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id]) || CourseAsset.find_by_id(params[:textbook_video][:course_asset_id])
    if @course_asset
      @assetable = @course_asset.assetable
      @course_assets = @assetable.course_assets.order(:position)
    end
  end
  
end
