class VideosController < ApplicationController
    
  before_filter :get_user_mode, :load_videos, :set_query_string
  
  # GET /videos
  # GET /videos.json
  def index

    get_drop_menu_data
     
    respond_to do |format|
      format.html {
        flash[:alert] = "No videos found." if (@videos.count == 0)
        @videos_current = @videos.where(archived:0).order("position")
        @videos_archived = @videos.where(archived:1).order("position")
        @videos_future = @videos.where(archived:2).order("position")
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
      format.html {
        get_drop_menu_data        
      }# show.html.erb
      format.json { render json: @video }
      format.js {
        get_drop_menu_data
      } # show.js.erb
    end
  end

  # GET /videos/new
  # GET /videos/new.json
  def new
    @video = @course_asset.videos.new
  end

  def replace
    @old_video = Video.find_by_id(params[:id])
    @video = @course_asset.videos.new
  end
  
  # POST /videos
  # POST /videos.json
  def create
    
    if params[:commit]  == "Cancel"
      if params[:video][:replace_flag]
        @ujsNotice = "Replace video action canceled."
      else
        @ujsNotice = "Add new video action canceled."
      end
      render "cancel"
      
    elsif params[:video][:replace_flag]
      # find the original video that is being replaced
      @old_video = Video.find_by_id(params[:video][:old_version_id])

      # build a new video from the new videofile
      @video = @course_asset.videos.build(params[:video].except(:course_id, :subject_id))
      @video.get_video_duration
      
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
        @video = @course_asset.videos.new
        render "replace"
      end

      # else create a brand new video
    else
      @video = @course_asset.videos.build(params[:video].merge({:instructor_id => current_instructor.id}).except(:course_id, :subject_id))
      @video.position = @course_asset.videos.where(:archived => current_tab_index).count + 1 
      @video.archived = current_tab_index
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

  # GET /videos/1/edit
  def edit
    @video = Video.find_by_id(params[:id])
    # @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
       
    @video = Video.find_by_id(params[:id])

   	if params[:commit]  == "Cancel"
      @ujsNotice = "Edit video action canceled."
      render "cancel"
      
    elsif params[:archived]
      @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
      posit = @course_asset.videos.where(:archived=>params[:archived]).count + 1
      @video.archived = params[:archived]
      @video.position = posit
      if !@video.save
        @ujsNotice = nil
        @ujsAlert = "Error! " + @video.errors.full_messages.first
      end
      render nothing: true
      
    else
      @course_asset = CourseAsset.find_by_id(params[:video][:course_asset_id])
      @video.update_attributes(:title => params[:video][:title], :description => params[:video][:description])
      if @video.save
        @ujsAlert = nil
        @ujsNotice = "Successfully edited video."
      else
        @ujsNotice = nil
        @ujsAlert = "Error! " + @video.errors.full_messages.first
        render "edit"
      end
    end
    
    
    
    
  end
  
  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    @ujsAlert = nil
    @ujsNotice = "Video has been successfully deleted."
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
 
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    if @course_asset
      @assetable = @course_asset.assetable
      @course_assets = @assetable.course_assets.order(:position)
      @videos = @course_asset.videos
    end
    
  end
  
end
