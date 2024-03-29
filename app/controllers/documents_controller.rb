class DocumentsController < ApplicationController
  
  before_filter :get_user_mode, :set_query_string
  
  def index
    
    get_drop_menu_data

    # set sortable mode for instructors or students who own the asset
    set_sortable_mode
     
    @documents = @course_asset.try(:documents)

    respond_to do |format|
      format.html {
    		if @documents
      		@documents_current  = @documents.where(:archived => 0).order("position")
      		@documents_archived = @documents.where(:archived => 1).order("position")
      		@documents_future   = @documents.where(:archived => 2).order("position")
      		if (@documents && @documents.count == 0)
      			@ujsAlert = "There currently are not any documents."
      		else
      			@ujsAlert = nil
      		end
    		end    
      }
      format.json {
        render json: @documents
      }
    end
        
  end


  def show
    @document = Document.find_by_id(params[:id])    
    respond_to do |format|
      format.html { get_drop_menu_data }# show.html.erb
      format.json { render json: @video }
      format.js   { get_drop_menu_data } # show.js.erb
    end    
  end

  def new
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @document = Document.new
  end

  def create
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    @document = @course_asset.documents.build(params[:document].except(:course_id, :subject_id))
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
      render nothing: true  
    
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
    
end
