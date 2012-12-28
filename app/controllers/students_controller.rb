class StudentsController < ApplicationController
	def index
  	@students = Student.find(:all)
  end

  def show
  	@student = Student.find_by_id(params[:id])
  	if @student.nil?
      @students = Student.find(:all)
  	  render "index", :alert => 'Student was not found'
	  end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
