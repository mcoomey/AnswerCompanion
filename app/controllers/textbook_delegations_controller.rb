class TextbookDelegationsController < ApplicationController

  before_filter :get_user_mode
  
  def index
    
    get_drop_menu_data
    
    set_query_string
    
    @textbookDels = @course_asset.try(:textbook_delegations)

    respond_to do |format|
      format.html {
    		if @textbookDels
      		@textbookDels_current  = @textbookDels.where(:archived => 0).order(:position)
      		@textbookDels_archived = @textbookDels.where(:archived => 1).order(:position)
      		@textbookDels_future   = @textbookDels.where(:archived => 2).order(:position)
      		if (@textbookDels.count == 0)
      			@ujsAlert = "No textbooks are currently assigned."
      		else
      			@ujsAlert = nil
      		end
    		end
      }
      format.json {
        render json: @textbookDels
      }
    end
    
    if @user_mode == "instructor" || @course_asset.try(:assetable_type) == "Subject"
      @sortable = "sortable"
    else
      @sortable = "not-sortable"
    end
       
  end
  
		
	def new
    @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
	  @textbook = Textbook.new
    @textbook_delegation = TextbookDelegation.new
    
	end
	
	def create
	  @textbook = Textbook.new
    @textbook_delegation = TextbookDelegation.new
    @textbook_delegation.archived = current_tab_index
    @textbook_delegation.course_asset_id = params[:course_asset_id]
    
	  tabs = [:Current, :Archived, :Future]
	  
   	if params[:commit]  != "Cancel"
  	  @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
      #get isbn from form, strip out the dashes and convert to ISBN13
      isbn = params[:textbook_delegation][:isbn13].delete("-")
      if ISBN.valid?(isbn)
    
        isbn13 = ISBN.thirteen(isbn)
        # check if textbook is currently in the database
        existingbook = Textbook.find_by_isbn13(isbn13)
    
        if existingbook
          # if so, check to see if it's already in the asset
          @tbdel = @course_asset.textbook_delegations.where(:textbook_id => existingbook.id).first
          if @tbdel
            #if so, report error and inform which tab
            @ujsAlert = "Error, textbook already added to #{tabs[@tbdel.archived].to_s} tab."
            render "new"
          else  
            # otherwise, add it to the currently selected tab
            add_to_current_tab(existingbook)
          end
        
        # otherwise, if textbook is not already in the database... 
        else
          # check for a match in Google books
          result = GoogleBooks.search('isbn:' + isbn13, {count: 4}) # return up to 4 results
          # if something close is found...
          if (result && result.count > 0)
          
            match_found = false
            #check each result
            result.each do |candidate|
            
              # if it's an exact match 
              if isbn13 == candidate.isbn_13
                match_found = true
                @textbook.isbn13 = candidate.isbn_13
              
                # check to see if the matching result is already in the database
                existingbook = Textbook.find_by_isbn13(@textbook.isbn13)
              
                if existingbook
                  # if so, check to see if it's already in the asset
                  @tbdel = @course_asset.textbook_delegations.where(:textbook_id => existingbook.id).first
                  if @tbdel
                    #if so, report error and inform which tab
                    @tbdelError = "Error, textbook already added to #{tabs[@tbdel.archived].to_s} tab."
                    break
                  else  
                    # otherwise, add it to the currently selected tab
                    add_to_current_tab(existingbook)
                    break
                  end

                # otherwise, if textbook is not already in the database add the new book to the database
                else
                  @textbook.title = candidate.title
                  @textbook.author = candidate.authors
                  @textbook.publisher = candidate.publisher
                  @textbook.image_link = candidate.image_link
                  @textbook.save
            
                  # and then add it to the current asset
                  add_to_current_tab(@textbook)
                  break
                end
                            
              end  #end exact isbn match if
              
            end  #end each candidate loop
            if !match_found
              @ujsAlert = "A book with matching ISBN was not found."
              render "new"
            end
          # matching textbook ISBN not found
          else
            @ujsAlert = "A book with matching ISBN was not found."
            render "new"
          end
      
        end
      else
        @ujsAlert = "Invalid ISBN was entered"
        render "new"
      end
      
    else
      # user canceled the action
      @ujsNotice = "Add new textbook action canceled."
      @ujsAlert = nil
      render "cancel"
    end
  end
  
	def edit
	 
	end
	
	def update
    if params[:archived]
      tbdel = TextbookDelegation.find_by_id(params[:id])
      tbdel.archived = params[:archived]
      # move it to the bottom of the target archived scope
      tbdel.position = TextbookDelegation.where(:archived => params[:archived]).count+1
      tbdel.save
      @ujsNotice = "Textbook has been moved to #{current_drop_tab.to_s} tab."
    end
    render "update"
	end
  
  def destroy
		tbdel = TextbookDelegation.find(params[:id])
		tbdel.destroy
    @ujsNotice = "Textbook was successfully removed."
  end
  
  def sort
    if params[:tbdel_id]
      params[:tbdel_id].each_with_index do |id, index|
        TextbookDelegation.update_all({position: index+1}, {id: id})
      end
    end
    render nothing: true
  end

private 

  def add_to_current_tab(textbook)
    @textbook_delegation.textbook_id = textbook.id
    @textbook_delegation.save
    @ujsAlert = nil
    @ujsNotice = "Successfully added new textbook."
    flash[:alert] = nil
  end
  
end
