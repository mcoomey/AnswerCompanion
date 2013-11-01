class CourseAssetsController < ApplicationController
  # GET /course_assets
  # GET /course_assets.json
  def index
    @course_assets = CourseAsset.all

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
        render :js => "window.location.href = '#{course_asset_textbook_delegations_path(@course_asset)}'"
        # otherwise just render the course
      else
        render :js => "window.location.href = '#{course_path(@course)}'"
      end
    end 
  end
  
end
