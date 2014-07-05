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
    @course_assets = @course.course_assets.order(:position)
    @documents = @course_asset.try(:documents)

		if @documents
  		@documents_current  = @documents.where(:archived => 0).order("position")
  		@documents_archived = @documents.where(:archived => 1).order("position")
  		@documents_future   = @documents.where(:archived => 2).order("position")
		end
    
		if (@documents && @documents.count == 0)
			flash[:alert] = "There currently are not any documents."
		else
			flash[:alert] = nil
		end
  end


  def show
    @instructor = current_instructor
    @courses = @instructor.courses.where(:archived => 0)
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @document = Document.find_by_id(params[:id])    
    @course = @document.course_asset.course
    @course_assets = @course.course_assets.order(:position)
  end

  def new
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @document = Document.new
  end

  def create
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @document = @course_asset.documents.build(params[:document])
    @document.position = Document.all.count + 1
    @action = "Create"
    
   	if params[:commit]  != "Cancel"
      @document.save
      render "create"
    else
      render "cancel"
    end
  end

  def edit
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @document = Document.find_by_id(params[:id])
  end

  def update
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @document = Document.find_by_id(params[:id])
    @action = "Update"
    
    if params[:archived]
      posit = @course_asset.documents.where(:archived=>params[:archived]).count + 1
      @document.archived = params[:archived]
      @document.position = posit
      @document.save
      render nothing: true
    
    elsif params[:commit]  != "Cancel"
      @document.description = params[:document][:description]
      @document.save
      
    else
      @document.destroy
      render "cancel"
    end
    
  end

  def destroy    
    @document = Document.find_by_id(params[:id])
    @document.destroy
  end
  
  def sort
    if params[:document_id]
      params[:document_id].each_with_index do |id, index|
        Document.update_all({position: index+1}, {id: id})
      end
    end
    render nothing: true  
  end
  
  
end
