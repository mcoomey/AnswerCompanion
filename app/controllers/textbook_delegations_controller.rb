class TextbookDelegationsController < ApplicationController

  def index
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>cookies[:horizontal_tabs_index]=#{cookies[:"horizontal_tabs_index"]}<<<<<<<<<<<<<<<<<<<<<<<<<<"
    
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
    @course_assets = @course.course_assets
		@textbookDels = @course_asset.try(:textbook_delegations)
		if (@textbookDels && @textbookDels.count == 0)
			flash[:alert] = "You must add at least 1 textbook."
		else
			flash[:alert] = nil
		end
	end
	
	def show
		
	end
	
	def new
	  @textbook = Textbook.new
	end
	
	def create
	  
	  @textbook = Textbook.new
	  
   	if params[:commit]  != "Cancel"
  	  @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
      isbn13 = params[:textbook][:isbn13]
    
      # check if textbook is currently in the database
      @existingbook = Textbook.find_by_isbn13(isbn13)
    
      # if so, just add it to the current course asset
      if @existingbook
        @course_asset.textbooks << @existingbook
        @tbdel = @course_asset.textbook_delegations.where(:textbook_id => @existingbook.id).first
        @tbdelError = nil
        @tbdelNotice = "Successfully added new textbook."
        
      # otherwise... 
      else
        # check for a match in Google books
        result = GoogleBooks.search(:isbn => isbn13)

        # if something close is found...
        if (result)
          @textbook.isbn13 = result.first.isbn_13
          # check to see if the matching result is already in the database
          @existingbook = Textbook.find_by_isbn13(@textbook.isbn13)
          
          # if so then add it to the current asset
          if @existingbook
            @course_asset.textbooks << @existingbook
            @tbdel = @course_asset.textbook_delegations.where(:textbook_id => @existingbook.id).first
            @tbdelError = nil
            @tbdelNotice = "Successfully added new textbook."
            
          #otherwise add the new book to the database
          else
            @textbook.title = result.first.title
            @textbook.author = result.first.authors
            @textbook.publisher = result.first.publisher
            @textbook.remote_frontcover_url = result.first.image_link
            @textbook.save
            
            # and then add it to the current asset
            @course_asset.textbooks << @textbook
            @tbdel = @course_asset.textbook_delegations.where(:textbook_id => @textbook.id).first
            @tbdelError = nil
            @tbdelNotice = "Successfully added new textbook."
          end
          
        # matching textbook ISBN not found
        else
          @tbdelError = "A text with matching ISBN was not found."
          render "new"
        end
      
      end
      
    else
      # user canceled the action
      @tbdelNotice = "Add new textbook action canceled."
      render "cancel"
    end
  end
	
  def destroy
		tbdel = TextbookDelegation.find(params[:id])
		tbdel.destroy
		redirect_to(:action => 'index', :anchor => "tabs-#{session[:selectedTab]}")
  end

end
