class SchoolsController < ApplicationController
  before_filter :load_schoolmember
  
  # GET /schools
  # GET /schools.json
  def index
    if !@schoolmember
      @schools = School.all
    else
      @schools = @schoolmember.schools
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { 
        @filtered_schools = School.order(:name).where("lower(name) like ?", "#{params[:term.downcase]}%")
        render json: @filtered_schools.map{|s| s.name + "||" + s.town +  "||" + State.find_by_id(s.state_id).abbrev}
      }
    end
  end

  def exists
    state_id = State.find_by_abbrev(params[:state])
    if !state_id
      render json: "-1"
    else
      school = School.where(name:params[:name], town:params[:town],state_id:state_id)
      if school.length > 0
        render json: "1"
      elsif school.new.valid?
        render json: "0"
      else
        render json: "-1"
      end
    end
  end

  # GET /schools/1
  # GET /schools/1.json
  def show
    @school = School.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @school }
    end
  end

  # GET /schools/new
  # GET /schools/new.json
  def new
    @school = School.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @school }
    end
  end

  # GET /schools/1/edit
  def edit
    @school = School.find(params[:id])
  end

  # POST /schools
  # POST /schools.json
  def create
    @school = School.new(params[:school])

    respond_to do |format|
      if @school.save
        format.html { redirect_to @school, notice: 'School was successfully created.' }
        format.json { render json: @school, status: :created, location: @school }
      else
        format.html { render action: "new" }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /schools/1
  # PUT /schools/1.json
  def update
    @school = School.find(params[:id])

    respond_to do |format|
      if @school.update_attributes(params[:school])
        format.html { redirect_to @school, notice: 'School was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy
    
    puts "***************** DESTROYING SCHOOL *******************"
    @school = School.find(params[:id])
    @school.destroy

    respond_to do |format|
      format.html { redirect_to schools_url }
      format.json { head :no_content }
    end
  end
  
  def load_schoolmember
    resource,id = request.path.split('/')[1,2]
    if ((resource == "instructors")||(resource == 'students'))
      @schoolmember = resource.singularize.classify.constantize.find(id)
    else
      @schoolmember = nil
    end
  end
  
end
