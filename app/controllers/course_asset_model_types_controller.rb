class CourseAssetModelTypesController < ApplicationController
  # GET /course_asset_model_types
  # GET /course_asset_model_types.json
  def index
    @course_asset_model_types = CourseAssetModelType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @course_asset_model_types }
    end
  end

  # GET /course_asset_model_types/1
  # GET /course_asset_model_types/1.json
  def show
    @course_asset_model_type = CourseAssetModelType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @course_asset_model_type }
    end
  end

  # GET /course_asset_model_types/new
  # GET /course_asset_model_types/new.json
  def new
    @course_asset_model_type = CourseAssetModelType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @course_asset_model_type }
    end
  end

  # GET /course_asset_model_types/1/edit
  def edit
    @course_asset_model_type = CourseAssetModelType.find(params[:id])
  end

  # POST /course_asset_model_types
  # POST /course_asset_model_types.json
  def create
    @course_asset_model_type = CourseAssetModelType.new(params[:course_asset_model_type])

    respond_to do |format|
      if @course_asset_model_type.save
        format.html { redirect_to @course_asset_model_type, notice: 'Course asset model type was successfully created.' }
        format.json { render json: @course_asset_model_type, status: :created, location: @course_asset_model_type }
      else
        format.html { render action: "new" }
        format.json { render json: @course_asset_model_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /course_asset_model_types/1
  # PUT /course_asset_model_types/1.json
  def update
    @course_asset_model_type = CourseAssetModelType.find(params[:id])

    respond_to do |format|
      if @course_asset_model_type.update_attributes(params[:course_asset_model_type])
        format.html { redirect_to @course_asset_model_type, notice: 'Course asset model type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @course_asset_model_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_asset_model_types/1
  # DELETE /course_asset_model_types/1.json
  def destroy
    @course_asset_model_type = CourseAssetModelType.find(params[:id])
    @course_asset_model_type.destroy

    respond_to do |format|
      format.html { redirect_to course_asset_model_types_url }
      format.json { head :no_content }
    end
  end
end
