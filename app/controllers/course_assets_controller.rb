class CourseAssetsController < ApplicationController
  
  before_filter :load_assetable
    
  # GET /course_assets
  # GET /course_assets.json
  def index
    @course_assets = @assetable? @assetable.course_assets.order(:position) : []

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
    @course_asset = @assetable.course_assets.new
  end

   # POST /course_assets
  def create
   	if params[:commit]  != "Cancel"  
      get_user_mode
      
      posit = @assetable.course_assets.count + 1
      @course_asset = @assetable.course_assets.new(params[:course_asset].merge(position: posit))
      if @course_asset.save
        @ujsAlert = nil
        @course_assets = @course_asset.assetable.course_assets.order(:position)
        @ujsNotice = "Successfully added new asset."
        if @assetable.class.to_s == "Course"
          @query_string = {:course_id => @assetable.id}
        else
          @query_string = {:subject_id => @assetable.id}
        end
      else
        @ujsAlert = @course_asset.errors.full_messages.first
        render "new"
      end
    else
      @ujsNotice = "Add new asset action canceled."
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
    
    if params[:commit] != "Cancel"
      if @course_asset.update_attributes(params[:course_asset])
        @ujsNotice = "Course asset was successfully updated."
        @ujsAlert = nil
        render "update"
      else
        @ujsNotice = nil
        @ujsAlert = @course_asset.errors.full_messages.first
        render "edit"
      end
    else
      @ujsNotice = "Update Course Asset action was canceled."
      render "cancel"
    end
  end

  # DELETE /course_assets/1
  def destroy
    @course_asset = CourseAsset.find(params[:id])
    @assetable = @course_asset.assetable
    if @assetable.class.to_s == "Course"
      @query_string = {:course_id => @assetable.id}
    else
      @query_string = {:subject_id => @assetable.id}
    end
    @course_asset.destroy

    ref_url = request.referrer.to_s
    orig_url = request.original_url.to_s
    
    # if user is deleting the currently selected asset
    if (ref_url.index orig_url) == 0
      # if there are any other assets associated with the course then render the first one
      @course_asset = @assetable.course_assets.try(:first)
      if @course_asset
        new_path = send("course_asset_#{CourseAssetModelType.find_by_id(@course_asset.model_type).name_of_model}_path", @course_asset, @query_string)
        render :js => "window.location.href = '#{new_path}'"
        
        # otherwise just render the course
      else
        render :js => "window.location.href = '#{course_path(@assetable, @query_string)}'"
      end
    else
      @ujsAlert = nil
      @ujsNotice = "Course Asset has been deleted."
    end 
  end
  
  def sort
    if params[:asset_tag]
      params[:asset_tag].each_with_index do |id, index|
        CourseAsset.update_all({position: index+1}, {id: id})
      end
    end
    render nothing: true  
  end

  private
  
  def load_assetable
    @resource, id = request.path.split('/')[1,2]
    @assetable = @resource.singularize.classify.constantize.find_by_id(id)
  end
  
    
end
