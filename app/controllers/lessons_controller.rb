class LessonsController < ApplicationController
  
  def get_subjectId
    @subjectId = params[:subject_id] if params[:subject_id]
    @subjectId = params[:filters][:subject_id] if params[:filters]
  end
  
  # GET /lessons
  # GET /lessons.json
  def index
    get_subjectId
    @subjectname = Subject.find(@subjectId).name if @subjectId
    @textbook = Textbook.find(params[:textbook_id])
    if params[:filters] && (params[:commit] != "Reset")
      @filterstring = params[:filters][:pagefilter]
      if @filterstring.include?('-')
        range = @filterstring.split('-')
        @lessons = @textbook.lessons.where("page between ? and ?", range[0].to_i, range[1].to_i).paginate(:page => params[:page], :per_page => 15)
      else
        @lessons = @textbook.lessons.where("page = ?", @filterstring).paginate(:page => params[:page], :per_page => 15)
      end
        
    else
      @filterstring = nil
      @lessons = @textbook.lessons.sort{|a,b| a.page.to_i <=> b.page.to_i}.paginate(:page => params[:page], :per_page => 15)
    end
    
    if (@lessons.count == 0)
      flash[:alert] = "No lessons found."
    end
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @lesson = Lesson.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lesson }
    end
  end

  def new
    get_subjectId
    @textbook = Textbook.find(params[:textbook_id])
    @lesson = Lesson.new
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @subjectId = params[:lesson][:subject_id]
    @textbook = Textbook.find(params[:textbook_id])
    @lessons = @textbook.lessons.paginate(:page => params[:page], :per_page => 15)
    @lesson = @textbook.lessons.build(:title => params[:lesson][:title], :page => params[:lesson][:page])
    @lesson.instructor_id = current_instructor.id if current_instructor
   	if params[:commit]  != "Cancel"
    	if @lesson.save
    		flash[:notice] = "Successfully created lesson."
    		flash[:alert] = nil
    	else  
    		flash[:notice] = nil
    	  flash[:alert] = "Error! " + @lesson.errors.full_messages.first
  		end
		end
	end

  # GET /lessons/1/edit
  def edit
    @subjectId = params[:subject_id]
    @textbook = Textbook.find(params[:textbook_id])
    @lesson = Lesson.find(params[:id])
    @lessons = @textbook.lessons.paginate(:page => params[:page], :per_page => 15)
  end

  # PUT /lessons/1
  # PUT /lessons/1.json
  def update
    @subjectId = params[:lesson][:subject_id] if params[:lesson]
    @lesson = Lesson.find(params[:id])
    @textbook = @lesson.textbook
    @lessons = @textbook.lessons.paginate(:page => params[:page], :per_page => 15)
   	if params[:commit]  != "Cancel"
    	if @lesson.update_attributes(:title => params[:lesson][:title], :page => params[:lesson][:page])
    		flash[notice] = "Successfully updated lesson."
    	end
  	end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson = Lesson.find(params[:id])
    @textbook = @lesson.textbook
    @lesson.destroy
    
		flash[notice] = "Lesson has been successfully deleted."
    redirect_to textbook_lessons_path(@textbook, :subject_id => params[:subject_id])
    
  end
end
