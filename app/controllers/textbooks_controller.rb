class TextbooksController < ApplicationController

  def index
    @selectedCat = "1"
    @selectedSubcat = "1"
    @disableSubcat = false
    if params[:category] 
      @selectedSubcat = "1";
      @selectedCat = params[:category][:id]
    elsif params[:subcategory] 
      @selectedSubcat = params[:subcategory][:id]
      @selectedCat = params[:subcategory][:category]
    end
    if @selectedCat == "1"
      @textbooks = Textbook.all(:order => "isbn13")
      @categories = Category.all
      @subcategories = Subcategory.all
      @disableSubcat = true
    elsif @selectedSubcat == "1"
      @textbooks = Textbook.all(:conditions => ["category_id = ?", @selectedCat], :order => "isbn13")
      @categories = Category.all
      @subcategories = Subcategory.all(:conditions => ["category_id = ? OR category_id = ?", "1", @selectedCat])
    else
      @textbooks = Textbook.all(:conditions => ["category_id = ? AND subcategory_id = ?", @selectedCat, @selectedSubcat], :order => "isbn13")
      @categories = Category.all
      @subcategories = Subcategory.all(:conditions => ["category_id = ? OR category_id = ?", "1", @selectedCat])
    end
    flash[:notice] = nil    
    flash[:alert] = nil
    
    respond_to do |format|
      format.html { #
      }
        
      format.json { 
        render json: @textbooks
        }
        
      format.xml {
        render xml: @textbooks
      }

    end
    
  end

  def show

  end

  def new
    @textbook = Textbook.new
  end

  def create
    @textbook = Textbook.new(params[:textbook])   
    result = GoogleBooks.search(:isbn => @textbook.userisbn)
    
    if result.first
      @textbook.isbn13 = result.first.isbn_13
      @textbook.title = result.first.title
      @textbook.author = result.first.authors
      @textbook.publisher = result.first.publisher
      @textbook.image_link = result.first.image_link
      
      if @textbook.save
        if (@textbook.userisbn != @textbook.isbn13)
          flash[:notice] = "Publication updated to ISBN13 = #{@textbook.isbn13}. Please enter missing details." 
        else
          flash[:notice] = "Publication found. Please enter missing details."
        end
        redirect_to edit_textbook_path(@textbook)
      else
        flash[:alert] = "Error for ISBN##{@textbook.userisbn}!  " + @textbook.errors.full_messages.first
        render action: "new"
      end
      
    else
      flash[:notice] = 'Publication not found.  Please check ISBN and proceed with caution.'
      render action: "new"
    end
  end

  def edit
    @textbook = Textbook.find(params[:id])
    @categoryid = @textbook.category ? @textbook.category.id : "1"
    @categoryname = Category.find_by_id(@categoryid).name
  end

  def update
    @textbook = Textbook.find(params[:id])
    if @textbook.update_attributes(params[:textbook])
      redirect_to @textbook, notice: 'Textbook was successfully updated.' 
    else
      render action: "edit"
    end
  end

  def destroy
    @textbook = Textbook.find(params[:id])
    @textbook.destroy
    redirect_to textbooks_url
  end
end
