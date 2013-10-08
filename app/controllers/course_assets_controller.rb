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
  # GET /course_assets/new.json
  def new
    @course_asset = CourseAsset.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course_asset }
    end
  end

  # GET /course_assets/1/edit
  def edit
    @course_asset = CourseAsset.find(params[:id])
  end

  # POST /course_assets
  # POST /course_assets.json
  def create
    @course_asset = CourseAsset.new(params[:course_asset])

    respond_to do |format|
      if @course_asset.save
        format.html { redirect_to @course_asset, notice: 'Course asset was successfully created.' }
        format.json { render json: @course_asset, status: :created, location: @course_asset }
      else
        format.html { render action: "new" }
        format.json { render json: @course_asset.errors, status: :unprocessable_entity }
      end
    end
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
  # DELETE /course_assets/1.json
  def destroy
    @course_asset = CourseAsset.find(params[:id])
    @course_asset.destroy

    respond_to do |format|
      format.html { redirect_to course_assets_url }
      format.json { head :no_content }
    end
  end
end
