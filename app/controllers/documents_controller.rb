class DocumentsController < ApplicationController
  
  before_filter :load_user, :only => [:index, :show]
  
  def index
    
    if params[:assetable]
      @assetable = @choices.find_by_id(params[:assetable][:id])
      @course_asset = @assetable.course_assets.try(:first)
      if @course_asset
        redirect_to send("course_asset_#{CourseAssetModelType.find_by_id(@course_asset.model_type).name_of_model}_path", @course_asset)
      else
        redirect_to polymorphic_path(@assetable)
      end

    else
      @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
      @assetable = @course_asset.assetable
      @course_assets = @assetable.course_assets.order(:position)
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
    
  end


  def show
    if params[:assetable]
      @assetable = @choices.find_by_id(params[:assetable][:id])
      @course_asset = @assetable.course_assets.try(:first)
      if @course_asset
        redirect_to send("course_asset_#{CourseAssetModelType.find_by_id(@course_asset.model_type).name_of_model}_path", @course_asset)
      else
        redirect_to polymorphic_path(@assetable)
      end

    else
      @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
      @assetable = @course_asset.assetable
      @course_assets = @assetable.course_assets.order(:position)
      @document = Document.find_by_id(params[:id])    
    end
    
  end

  def new
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @document = Document.new
  end

  def create
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @document = @course_asset.documents.build(params[:document])
    @document.position = @course_asset.documents.where(:archived => current_tab_index).count + 1
    @document.archived = current_tab_index
    
   	if params[:commit]  != "Cancel"
      if @document.save
        @ujsAlert = nil
        @ujsNotice = "Successfully added document."
        render "create"
      else
        @ujsNotice = nil
        @ujsAlert = "Error! " + @document.errors.full_messages.first
        render "new"
      end
    else
      @ujsNotice = "Add new document action canceled."
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
      @ujsNotice = "Document has been moved to #{current_drop_tab.to_s} tab."
      render "update"
    
    elsif params[:commit]  != "Cancel"
      @document.description = params[:document][:description]
      if @document.save
        @ujsNotice = "Document was successfully updated."
        @ujsAlert = nil
        render "update"
      else
        @ujsNotice = nil
        @ujsAlert = @document.errors.full_messages.first
        render "edit"
      end
    else
      @ujsNotice = "Update document action was canceled."
      @ujsAlert = nil
      render "cancel"
    end
    
  end
  
  def destroy    
    @document = Document.find_by_id(params[:id])
    @document.destroy
    @ujsNotice = "Document was successfully deleted."
  end
  
  def sort
    if params[:document_id]
      params[:document_id].each_with_index do |id, index|
        Document.update_all({position: index+1}, {id: id})
      end
    end
    render nothing: true  
  end
  
  private
  
  def load_user
    if current_user.class.to_s == "Instructor"
      @user = current_instructor
      @choices = @user.courses.where(:archived => 0)
    elsif current_user.class.to_s == "Student"
      @user = current_student
      @choices = @user.subjects.where(:archived => 0)
    else
      @user = current_parent
      # to_be_completed
    end
  end
  
end
