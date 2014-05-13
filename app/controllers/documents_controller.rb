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
  end

  def new
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @document = Document.new
  end

  def create
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @document = @course_asset.documents.build(params[:document])
    @document.position = Document.all.count + 1
    
   	if params[:commit]  != "Cancel"
      @document.save
      render "create"
    else
      @action = "Create"
      render "cancel"
    end
  end

  def edit
    puts ">>>>>>>>>>>>>Edit Document<<<<<<<<<<<<<<<<<<"
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @document = Document.find_by_id(params[:id])
  end

  def update
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @document = Document.find_by_id(params[:id])
    
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
      @action = "Update"
      render "cancel"
    end
    
  end

  def destroy    
    @document = Document.find_by_id(params[:id])
    @document.destroy
  end
  
  def sort
    docs = params[:document_id]
    idx = 0
    if docs && docs.count > 0
      docs.each do |doc_id|
        document = Document.find_by_id(doc_id)
        document.position = idx
        document.save
        idx = idx + 1
      end
    end      
    render nothing: true
  end
  
  
end
