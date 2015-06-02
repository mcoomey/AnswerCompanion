class TextbookVideosController < ApplicationController
  
  before_filter :get_user_mode, :load_tbvideos, :set_query_string
  
  # GET /videos
  # GET /videos.json
  def index
    
    get_drop_menu_data
     
    respond_to do |format|
      format.html { @ujsAlert = "No videos found." if (@textbook_videos.count == 0) }
      format.json { render json: @textbook_videos }
    end
    
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @video = TextbookVideo.find(params[:id])
    respond_to do |format|
      format.html { get_drop_menu_data }# show.html.erb
      format.json { render json: @video }
      format.js   { get_drop_menu_data } # show.js.erb
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
      @course_asset = CourseAsset.find_by_id(params[:textbook_video][:course_asset_id])
      
      # find the original video that is being replaced
      @old_video = TextbookVideo.find_by_id(params[:textbook_video][:old_version_id])
            
      # get @videoable from the old version
      @videoable = @old_video.videoable
      
      # build a new video from the new videofile 
      @video = @videoable.textbook_videos.build(params[:textbook_video].except(:course_asset_id, :course_id, :subject_id))
      @video.get_video_duration
      @video.textbook_id = @old_video.textbook_id
      @video.instructor_id = @old_video.instructor_id
      
      
      @action = "Replace"
            
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
        @video = @videoable.textbook_videos.new
        render "replace"
      end

    # else create a brand new video
    else
      @course_asset = CourseAsset.find_by_id(params[:textbook_video][:course_asset_id])
      @video = @videoable.textbook_videos.build(params[:textbook_video].except(:course_asset_id, :course_id, :subject_id))
      @action = "Create"
      if @video.save
        @ujsAlert = nil
        @ujsNotice = "Video upload has been submitted for processing."
        @video.do_video_conversion
        render "create"
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
  
  def load_tbvideos
    @resource, id = request.path.split('/')[1,2]
    @videoable = @resource.singularize.classify.constantize.find_by_id(id)
    if @videoable
      @textbook = @videoable.textbook
      @textbook_videos = @videoable.textbook_videos
    end
  end
  
end
