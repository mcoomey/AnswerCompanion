class InstructorsController < ApplicationController
  
  def index
  	@instructors = Instructor.find(:all)
  end

  def show
  	@instructor = Instructor.find(params[:id])
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
