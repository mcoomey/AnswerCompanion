class DocumentsController < ApplicationController
  def index
    @instructor = current_instructor
    @courses = @instructor.courses.where(:archived => 0)
    if params[:course]
      @course = Course.find_by_id(params[:course][:id])
      @course_asset = @course.course_assets.try(:first)
      if @course_asset
        redirect_to course_asset_documents_path(@course_asset)
      else
        redirect_to course_path(@course)
      end
    else
      @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
      @course = @course_asset.course
    end
    @course_assets = @course.course_assets
    @documents = @course_asset.try(:documents)

		if @documents
  		@documents_current  = @documents.where(:archived => 0).order("position DESC")
  		@documents_archived = @documents.where(:archived => 1).order("position DESC")
  		@documents_future   = @documents.where(:archived => 2).order("position DESC")
		end
    
		if (@documents && @documents.count == 0)
			flash[:alert] = "There currently are not any documents."
		else
			flash[:alert] = nil
		end
  end


  def show
  end

  def new
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @document = Document.new
  end

  def create
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @document = @course_asset.documents.build(params[:document])
   	if params[:commit]  != "Cancel"
      @document.save
      render "create"
    else
      @action = "Create"
      render "cancel"
    end
  end

  def edit
  end

  def update
  end

  def destroy    
    @document = Document.find_by_id(params[:id])
    @document.destroy
  end
end
