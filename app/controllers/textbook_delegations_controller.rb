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
    @course_assets = @course.course_assets
		@textbookDels = @course_asset.try(:textbook_delegations)
		if @textbookDels
  		@textbookDels_current  = @textbookDels.where(:archived => 0)
  		@textbookDels_archived = @textbookDels.where(:archived => 1)
  		@textbookDels_future   = @textbookDels.where(:archived => 2)
		end
		if (@textbookDels && @textbookDels.count == 0)
			flash[:alert] = "No textbooks are currently assigned."
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
        puts ">>>>>>>>>>>>>>result.count = #{result.count}<<<<<<<<<<<<<<<<<"
        # if something close is found...
        if (result && result.count > 0)
          
          #check each result
          result.each do |candidate|
            
            puts ">>>>>>>>>>>>trying ISBN #{candidate.isbn_13}<<<<<<<<<<<<<<<<<<<<"
            
            # if it's an exact match 
            if isbn13 == candidate.isbn_13
              puts ">>>>>>>>>>exact match found in Googlebooks<<<<<<<<<<<<<<<<<<<"
              @textbook.isbn13 = candidate.isbn_13
              
              # check to see if the matching result is already in the database
              existingbook = Textbook.find_by_isbn13(@textbook.isbn13)
              
              if existingbook
                puts ">>>>>>>>>>exact match found in the database<<<<<<<<<<<<<<<<<<<"
                # if so, check to see if it's already in the asset
                @tbdel = @course_asset.textbook_delegations.where(:textbook_id => existingbook.id).first
                if @tbdel
                  puts ">>>>>>>>>>exact match already in the asset<<<<<<<<<<<<<<<<<<<"
                  #if so, report error and inform which tab
                  @tbdelError = "Error, textbook already added to #{tabs[@tbdel.archived].to_s} tab."
                  break
                else  
                    puts ">>>>>>>>>>exact match getting added to selected tab<<<<<<<<<<<<<<<<<<<"
                  # otherwise, add it to the currently selected tab
                  add_to_current_tab(tabs, existingbook)
                  break
                end

              # otherwise, if textbook is not already in the database add the new book to the database
              else
                puts ">>>>>>>>>>exact match not found in database<<<<<<<<<<<<<<<<<<<"
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
    tbdel = TextbookDelegation.find(params[:id])
    newval = params[:tbdel][:archive]
    puts ">>>>>>>>>>newval=#{newval}<<<<<<<<<<<<<<<"
    tbdel.archived = newval
    tbdel.save
	end
  
  def destroy
		tbdel = TextbookDelegation.find(params[:id])
		tbdel.destroy
		redirect_to(:action => 'index', :anchor => "tabs-#{session[:selectedTab]}")
  end

private 

  def current_horizontal_tab
	  selected = cookies[:horizontal_tabs_index][1..-1] #remove first character (. or #)
	  if selected == "current-asset"
	    return :Current
    elsif selected == "archived-asset"
      return :Archived
    elsif selected == "future-asset"
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
