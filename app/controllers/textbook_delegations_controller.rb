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
    @textbook_delegation = TextbookDelegation.new
    @textbook_delegation.archived = current_tab_index
    
	end
	
	def create
	  
    puts ">>>>>>>>Creating TextbookDelegation<<<<<<<<<<<<<<<<<"
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
            @tbdelError = "Error, textbook already added to #{tabs[@tbdel.archived].to_s} tab."
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
            
              puts ">>>>>>isbn13=#{isbn13} and candidate.isbn_13=#{candidate.isbn_13}<<<<<<<<"
              # if it's an exact match 
              if isbn13 == candidate.isbn_13
                match_found = true
                puts ">>>>>>match found: #{candidate.isbn_13}<<<<<<"
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
              @tbdelError = "A book with matching ISBN was not found."
              render "new"
            end
          # matching textbook ISBN not found
          else
            @tbdelError = "A book with matching ISBN was not found."
            render "new"
          end
      
        end
      else
        @tbdelError = "Invalid ISBN was entered"
        render "new"
      end
      
    else
      # user canceled the action
      @tbdelNotice = "Add new textbook action canceled."
      @tbdelError = nil
      render "cancel"
    end
  end
  
	def edit
	 
	end
	
	def update
    puts ">>>>>>>>Updating TestbookDelegation<<<<<<<<<<<<"
    if params[:archived]
      tbdel = TextbookDelegation.find_by_id(params[:id])
      tbdel.archived = params[:archived]
      # move it to the bottom of the target archived scope
      tbdel.position = TextbookDelegation.where(:archived => params[:archived]).count+1
      tbdel.save
    end
    render nothing: true
	end
  
  def destroy
		tbdel = TextbookDelegation.find(params[:id])
		tbdel.destroy
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
    @tbdelError = nil
    @tbdelNotice = "Successfully added new textbook."
    flash[:alert] = nil
  end
  
end
