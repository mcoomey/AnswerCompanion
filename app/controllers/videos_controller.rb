class VideosController < ApplicationController
  
  def get_subjectId
    @subjectId = params[:subject_id] if params[:subject_id]
    @subjectId = params[:filters][:subject_id] if params[:filters]
  end

  # GET /videos
  # GET /videos.json
  def index
    # get_subjectId
    # @subjectname = Subject.find(@subjectId).name
    @lesson = Lesson.find(params[:lesson_id])
    @textbook = @lesson.textbook
    @videos = @lesson.videos

    respond_to do |format|
      format.html # index.html.erb
      format.json { }
    end
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    get_subjectId
    @subjectname = Subject.find(@subjectId).name
    @video = Video.find(params[:id])
    @lesson = Lesson.find(params[:lesson_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @video }
    end
  end

  # GET /videos/new
  # GET /videos/new.json
  def new
    get_subjectId
    @subjectname = Subject.find(@subjectId).name
    @lesson = Lesson.find(params[:lesson_id])
    @textbook = @lesson.textbook
    @videos = @lesson.videos
    @video = Video.new
 end

  # POST /videos
  # POST /videos.json
  def create
    @subjectId = params[:video][:subject_id]
    @lesson = Lesson.find(params[:lesson_id])
    @textbook = @lesson.textbook
    @videos = @lesson.videos
    @video = @videos.build(:videofile => params[:video][:videofile])
    @video.instructor_id = current_instructor.id if current_instructor
    @video.textbook_id = @textbook.id
   	if params[:commit]  != "Cancel"
      if !@video.save
        flash[:alert] = "Error: " + @video.errors.full_messages.first
        redirect_to lesson_videos_path(@lesson, :subject_id => @subjectId)
      end
    else  
      redirect_to lesson_videos_path(@lesson, :subject_id => @subjectId)
    end
 end

  # GET /videos/1/edit
  def edit
    @video = Video.find(params[:id])
  end

  # PUT /videos/1
  # PUT /videos/1.json
  def update
    @video = Video.find(params[:id])

    respond_to do |format|
      if @video.update_attributes(params[:video])
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @lesson = Lesson.find(params[:lesson_id])
    @video = Video.find(params[:id])
    @video.destroy
		flash[:notice] = "Video has been deleted."
    redirect_to lesson_videos_path(@lesson, :subject_id => params[:subject_id])
  end
 
end
