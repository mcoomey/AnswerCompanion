class TextbookDelegationsController < ApplicationController

  def index
    @instructor = current_instructor
    @courses = @instructor.courses.where(:archived => false)
    if params[:course]
      @course = Course.find_by_id(params[:course][:id])
      @course_asset = @course.course_assets.try(:first)
      if @course_asset
        redirect_to course_asset_textbook_delegations_path(@course_asset)
      else
        redirect_to course_path(@course)
      end
    else
      @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
      @course = @course_asset.course
    end
    @course_assets = @course.course_assets.order(:position)
		@textbookDels = @course_asset.try(:textbook_delegations)
		if @textbookDels
  		@textbookDels_current  = @textbookDels.where(:archived => 0).order(:position)
  		@textbookDels_archived = @textbookDels.where(:archived => 1).order(:position)
  		@textbookDels_future   = @textbookDels.where(:archived => 2).order(:position)
		end
		if (@textbookDels && @textbookDels.count == 0)
			flash[:alert] = "No textbooks are currently assigned."
		else
			flash[:alert] = nil
		end
	end
	
	def show
    @instructor = current_instructor
    @courses = @instructor.courses.where(:archived => 0)
    if params[:course]
      @course = Course.find_by_id(params[:course][:id])
      @course_asset = @course.course_assets.try(:first)
      if @course_asset
        redirect_to course_asset_textbook_delegations_path(@course_asset)
      else
        redirect_to course_path(@course)
      end
    else
      @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
      @course = @course_asset.course
    end
    @course_assets = @course.course_assets.order(:position)
    @textbook = TextbookDelegation.find_by_id(params[:id]).textbook
		
	end
	
	def new
	  @textbook = Textbook.new
	end
	
	def create
	  
	  @textbook = Textbook.new
	  tabs = [:Current, :Archived, :Future]
	  
   	if params[:commit]  != "Cancel"
  	  @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
      isbn13 = params[:textbook][:isbn13]
    
      # check if textbook is currently in the database
      existingbook = Textbook.find_by_isbn13(isbn13)
    
      if existingbook
        # if so, check to see if it's already in the asset
        @tbdel = @course_asset.textbook_delegations.where(:textbook_id => existingbook.id).first
        if @tbdel
          #if so, report error and inform which tab
          @tbdelError = "Error, textbook already added to #{tabs[@tbdel.archived].to_s} tab."
        else  
          # otherwise, add it to the currently selected tab
          add_to_current_tab(tabs, existingbook)
        end
        
      # otherwise, if textbook is not already in the database... 
      else
        # check for a match in Google books
        result = GoogleBooks.search('isbn:' + isbn13, {count: 4}) # return up to 4 results
        # if something close is found...
        if (result && result.count > 0)
          
          #check each result
          result.each do |candidate|
            
            # if it's an exact match 
            if isbn13 == candidate.isbn_13
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
                  add_to_current_tab(tabs, existingbook)
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
                add_to_current_tab(tabs, @textbook)
                break
              end
                            
            end  #end exact isbn match if
              
          end  #end each candidate loop
          
        # matching textbook ISBN not found
        else
          @tbdelError = "A book with matching ISBN was not found."
        end
      
      end
      
    else
      # user canceled the action
      @tbdelNotice = "Add new textbook action canceled."
      render "cancel"
    end
  end
  
	def edit
	 
	end
	
	def update
    if params[:archived]
      tbdel = TextbookDelegation.find_by_id(params[:id])
      posit = tbdel.course_asset.textbook_delegations.where(:archived=>params[:archived]).count + 1
      tbdel.archived = params[:archived]
      tbdel.position = posit
      tbdel.save
    end
    render nothing: true
	end
  
  def destroy
		tbdel = TextbookDelegation.find(params[:id])
		tbdel.destroy
  end
  
  def sort
    tbdels = params[:tbdel_id]
    idx = 1
    if tbdels && tbdels.count > 0
      tbdels.each do |tbid|
        tbdel = TextbookDelegation.find_by_id(tbid)
        tbdel.position = idx
        tbdel.save
        idx = idx + 1
      end
    end      
    render nothing: true
  end

private 

  def current_horizontal_tab
	  selected = cookies[:horizontal_tabs_index][1..-1] #remove first character (. or #)
	  if selected == "current-tab"
	    return :Current
    elsif selected == "archived-tab"
      return :Archived
    elsif selected == "future-tab"
      return :Future
    else
      return nil
    end
  end

  def add_to_current_tab(tabs, textbook)
    @course_asset.textbooks << textbook
    @tbdel = @course_asset.textbook_delegations.where(:textbook_id => textbook.id).first
    @tbdel.archived = tabs.index(current_horizontal_tab())
    @tbdel.save
    @tbdelError = nil
    @tbdelNotice = "Successfully added new textbook."
    flash[:alert] = nil
  end

end
