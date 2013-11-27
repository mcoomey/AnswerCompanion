class SectionTitlesController < ApplicationController
  # GET /section_titles
  # GET /section_titles.json
  def index
    
    if params[:textbook_id]
      textbook = Textbook.find_by_id(params[:textbook_id])
      @section_titles = textbook.section_titles.order(:name).where("name like ?", "%#{params[:term]}%")
    else
      @section_titles = SectionTitle.order(:name)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @section_titles.map(&:name) }
    end
  end

  # GET /section_titles/1
  # GET /section_titles/1.json
  def show
    @section_title = SectionTitle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @section_title }
    end
  end

  # GET /section_titles/new
  # GET /section_titles/new.json
  def new
    @section_title = SectionTitle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @section_title }
    end
  end

  # GET /section_titles/1/edit
  def edit
    @section_title = SectionTitle.find(params[:id])
  end

  # POST /section_titles
  # POST /section_titles.json
  def create
    @section_title = SectionTitle.new(params[:section_title])

    respond_to do |format|
      if @section_title.save
        format.html { redirect_to @section_title, notice: 'Section title was successfully created.' }
        format.json { render json: @section_title, status: :created, location: @section_title }
      else
        format.html { render action: "new" }
        format.json { render json: @section_title.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /section_titles/1
  # PUT /section_titles/1.json
  def update
    @section_title = SectionTitle.find(params[:id])

    respond_to do |format|
      if @section_title.update_attributes(params[:section_title])
        format.html { redirect_to @section_title, notice: 'Section title was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @section_title.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /section_titles/1
  # DELETE /section_titles/1.json
  def destroy
    @section_title = SectionTitle.find(params[:id])
    @section_title.destroy

    respond_to do |format|
      format.html { redirect_to section_titles_url }
      format.json { head :no_content }
    end
  end
end
