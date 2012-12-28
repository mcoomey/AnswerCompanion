class SubcategoriesController < ApplicationController
  before_filter :findCategory
  
  def findCategory
    if params[:category_name]
      @category = Category.find_by_name(params[:category_name])
    else
      @category = Category.find(params[:category_id])
    end
    
    @category ||= Category.find(1)  # if it's a new category use the "All" categories so subcategories won't fail
    
    puts "****** @category = #{@category.name} ******" if @category
  end
  
  def index
    @subcategories = @category.subcategories.all(:order => "category_id")
    @filteredsubcats = @category.subcategories.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { 
        render json: @filteredsubcats.map(&:name)
        }
    end
  end

  def show
    @subcategory = @category.subcategories.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @subcategory }
    end
  end

  def new
    @subcategory = @category.subcategories.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @subcategory }
    end
  end

  def edit
    @subcategory = @category.subcategories.find(params[:id])
  end

  def create
    @subcategory = @category.subcategories.new(params[:subcategory])

    respond_to do |format|
      if @subcategory.save
        format.html { redirect_to [@category, @subcategory], notice: 'Subcategory was successfully created.' }
        format.json { render json: @subcategory, status: :created, location: @subcategory }
      else
        format.html { render action: "new" }
        format.json { render json: @subcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @subcategory = Subcategory.find(params[:id])

    respond_to do |format|
      if @subcategory.update_attributes(params[:subcategory])
        format.html { redirect_to [@category, @subcategory], notice: 'Subcategory was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @subcategory.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @subcategory = Subcategory.find(params[:id])
    @subcategory.destroy

    respond_to do |format|
      format.html { redirect_to category_subcategories_url }
      format.json { head :no_content }
    end
  end
end
