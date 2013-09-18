class TextbookDelegationsController < ApplicationController
  before_filter :load_textable

  def index
		@textbookDels = @textable.textbook_delegations
		if (@textbookDels.count == 0)
			flash[:alert] = "You must add at least 1 textbook."
		else
			flash[:alert] = nil
		end
    @subjectcount = 0  # DEBUG
	end
	
	def show
		
	end
	
	def new
    @selectedCat = "1"
    @selectedSubcat = "1"
    @disableSubcat = false
    
    if params[:search]
      @searchItem = params[:search][:searchitem]
      @selectedCat = params[:search][:category]
      @selectedSubcat = params[:search][:subcategory]
    elsif params[:category] 
      @searchItem = nil
      @selectedSubcat = "1";
      @selectedCat = params[:category][:id]
    elsif params[:subcategory] 
      @searchItem = nil
      @selectedSubcat = params[:subcategory][:id]
      @selectedCat = params[:subcategory][:category]
    end
    
    @categories = Category.all
    if @selectedCat == "1"
      textbooks = Textbook.order('title')
      @subcategories = Subcategory.all
      @disableSubcat = true
    elsif @selectedSubcat == "1"
      textbooks = Textbook.where("category_id = ?", @selectedCat)
      @subcategories = Subcategory.where("category_id = ? OR category_id = ?", "1", @selectedCat)
    else
      textbooks = Textbook.where("category_id = ? AND subcategory_id = ?", @selectedCat, @selectedSubcat)
      @subcategories = Subcategory.where("category_id = ? OR category_id = ?", "1", @selectedCat)
    end
   
    if @searchItem
      textbooks = textbooks.where("title like ? OR isbn13 like ?", "%#{@searchItem}%", "%#{@searchItem}%")
    end
    @textbooks = textbooks.paginate :page => params[:page], :per_page => 10
    if @textbooks.count == 0
      flash[:alert] = "No matching textbooks found."
    else
      flash[:alert] = nil
    end
	end
	
	def create
    @tbdel = TextbookDelegation.new
    @tbdel.subject_id = params[:subject_id]
    @tbdel.textbook_id = params[:id]
    if @tbdel.save
      flash[:notice] = "Textbook has been successfully added."
      redirect_to (subject_textbook_delegations_path(params[:subject_id])+"#tabs-#{session[:selectedTab]}")
    else
      flash[:alert] = "Error adding textbook!  " + @tbdel.errors.full_messages.first
      render action: "new"
    end		
	end
	
  def destroy
		tbdel = TextbookDelegation.find(params[:id])
		title = tbdel.textbook.title
		flash[:notice] = title + " was successfully removed."
		tbdel.destroy
		redirect_to(:action => 'index', :anchor => "tabs-#{session[:selectedTab]}")
  end

  def load_textable
    resource, id = request.path.split('/')[1, 2]
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>resource = #{resource}   id = #{id}"
    @textable = resource.singularize.classify.constantize.find(id)
  end

end
