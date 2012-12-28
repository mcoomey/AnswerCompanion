class SubjectsController < ApplicationController

before_filter :findsubjects

  def findsubjects
  	@subjectable = find_subjectable
   	if (@subjectable)
  		@subjects = @subjectable.subjects
  		@subjectcount = @subjects.count
  	else 
  		@subjects = nil
  		@subjectcount = 0
  	end
  end
  
  def find_subjectable
  	params.each do |name, value|
  		if name =~ /(.+)_id$/
  			if $1.classify.constantize.exists?(value)
  				return $1.classify.constantize.find(value)
  			else
  				return nil
  			end
  		end
  	end
  	nil
  end

  def index
  	if (@subjectcount == 0)
  		flash[:alert] = "You need to add at least one subject."
  	end
  		
  end

  def show
  end

  def new
  	@subject = Subject.new
  end

  def create
  	@subject = @subjectable.subjects.build(params[:subject])
   	if params[:commit]  != "Cancel"
    	if @subject.save
    		flash[:notice] = "Successfully created subject."
    		session[:selectedTab] = @subjectable.subjects.count
    		respond_to do |format|
    		  format.html { 
    		    redirect_to(:controller => 'textbook_delegations', :action => 'index', :subject_id => @subject.id.to_s, :anchor => "tabs-#{session[:selectedTab]}")
  		    }
  		    format.js
  	    end
    	else
    		respond_to do |format|
    		  format.html { 
        	  flash[:alert] = "Error! " + @subject.errors.full_messages.first
      		}
      		format.js
    		end
  		end
  	end
  end

  def edit
  	@subject = Subject.find(params[:id])
  end

  def update
   	@subject = Subject.find(params[:id])
   	if params[:commit]  != "Cancel"
    	if @subject.update_attributes(params[:subject])
    		flash[notice] = "Successfully updated subject."
    		respond_to do |format|
    		  format.html { redirect_to(:controller => 'textbook_delegations', :action => 'index', 
    		                :subject_id => @subject.id.to_s, :anchor => "tabs-#{session[:selectedTab]}")}
    		  format.js
  		  end
    	else
    		respond_to do |format|
    		  format.html {render :action => 'edit'}
    		  format.js 
  		  end
    	end
  	end
  end

  def destroy
    subject = Subject.find(params[:id])
    subject.destroy
    flash[:notice] = "Subject deleted."
    
		@subjects = @subjectable.subjects
		if @subjects.count == 0
		  redirect_to(:action => 'index')
		else
		  redirect_to(:controller => 'textbook_delegations', :action => 'index', :subject_id => @subjects.first.id.to_s)
		end	
  end
end

