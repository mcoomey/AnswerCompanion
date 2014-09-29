class TextbooksController < ApplicationController

  def index
      @textbooks = Textbook.all(:order => "isbn13")
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
   end

  def edit
    @textbook = Textbook.find(params[:id])
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
