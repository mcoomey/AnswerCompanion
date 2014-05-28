class CourseAssetsController < ApplicationController
  # GET /course_assets
  # GET /course_assets.json
  def index
    if params[:course_id]
      @course = Course.find_by_id(params[:course_id])
      @course_assets = @course.course_assets.order(:position)
    else
      @course_assets = CourseAsset.all
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @course_assets }
    end
  end

  # GET /course_assets/1
  # GET /course_assets/1.json
  def show
    @course_asset = CourseAsset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course_asset }
    end
  end

  # GET /course_assets/new
  def new
    @course_asset = CourseAsset.new
    @course = Course.find_by_id(params[:course_id])
  end

   # POST /course_assets
  def create
   	if params[:commit]  != "Cancel"
      @course_asset = CourseAsset.new(params[:course_asset])
      if @course_asset.save
        @course_asset_error = nil
        @course_assets = @course_asset.course.course_assets.order(:position)
      else
        @course_assetError = @course_asset.errors.full_messages.first
      end
    else
      @course_assetNotice = "Add new asset action canceled."
      render "cancel"
    end
  end

 # GET /course_assets/1/edit
  def edit
    @course_asset = CourseAsset.find(params[:id])
  end

  # PUT /course_assets/1
  # PUT /course_assets/1.json
  def update
    @course_asset = CourseAsset.find(params[:id])

    respond_to do |format|
      if @course_asset.update_attributes(params[:course_asset])
        format.html { redirect_to @course_asset, notice: 'Course asset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course_asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_assets/1
  def destroy
    @course_asset = CourseAsset.find(params[:id])
    @course = @course_asset.course
    @course_asset.destroy

    ref_url = request.referrer.to_s
    orig_url = request.original_url.to_s
    
    # if user is deleting the currently selected asset
    if (ref_url.index orig_url) == 0
      # if there are any other assets associated with the course then render the first one
      @course_asset = @course.course_assets.try(:first)
      if @course_asset
        new_path = send("course_asset_#{CourseAssetModelType.find_by_id(@course_asset.model_type).model_name}_path", @course_asset)
        render :js => "window.location.href = '#{new_path}'"
        
        # otherwise just render the course
      else
        render :js => "window.location.href = '#{course_path(@course)}'"
      end
    end 
  end
  
  def sort
    assets = params[:asset_tag]
    idx = 1
    if assets && assets.count > 0
      assets.each do |assetid|
        asset = CourseAsset.find_by_id(assetid)
        asset.position = idx
        asset.save
        idx = idx + 1
      end
    end    
    render nothing: true  
  end

  
end
