class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to screens_index_path, :alert => "Unauthorized access. You have been redirected."
  end
  
  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
  
  
  def current_user
		(current_student || current_instructor || current_parent)
	end
	
  def current_horizontal_tab
	  selected = cookies[:horizontal_tabs_index][1..-1] #remove first character (. or #)
	  if selected == "current-tab"
	    return :Current
    elsif selected == "archived-tab"
      return :Archived
    elsif selected == "future-tab"
      return :Future
    else
      return nil
    end
  end

  def current_drop_tab
	  selected = cookies[:dropTab][1..-1] #remove first character (. or #)
	  if selected == "current-tab"
	    return :Current
    elsif selected == "archived-tab"
      return :Archived
    elsif selected == "future-tab"
      return :Future
    else
      return :Unknown
    end
  end

  def current_tab_index
	  [:Current, :Archived, :Future].index(current_horizontal_tab())
  end
  
  def get_user_mode
    @user = current_user
    @user_mode = cookies[:user_mode]
  end
  
  
  
  def get_drop_menu_data
    
    if @user_mode == "instructor"
      
      @choices = @user.courses.where(:archived => 0)
      @asset_type = "Course Assets"
    
      if params[:course] # drop-down menu
        @course = Course.find_by_id(params[:course][:id])
        @query_string = {:course_id => @course.id}
        @course_assets = @course.course_assets
        @course_asset = @course.course_assets.try(:first)
        if @course_asset
          redirect_to send("course_asset_#{CourseAssetModelType.find_by_id(@course_asset.model_type).name_of_model}_path", @course_asset, @query_string)
        else
          redirect_to course_path(@course, @query_string)
        end
      else
        @course = Course.find_by_id(params[:course_id])
        @query_string = {:course_id => @course.id}
        @course_assets = @course.course_assets
        @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
    		@textbookDels = @course_asset.try(:textbook_delegations)
        
    		if @textbookDels
      		@textbookDels_current  = @textbookDels.where(:archived => 0).order(:position)
      		@textbookDels_archived = @textbookDels.where(:archived => 1).order(:position)
      		@textbookDels_future   = @textbookDels.where(:archived => 2).order(:position)
      		if (@textbookDels.count == 0)
      			@ujsAlert = "No textbooks are currently assigned."
      		else
      			@ujsAlert = nil
      		end
    		end
        @assetable = @course
      end
      
    elsif @user_mode == "student"

    
      if params[:subject]
        @subject = Subject.find_by_id(params[:subject][:id])
        @query_string = {:subject_id => @subject.id}
        @course_assets = @subject.course_assets
        @course_asset = @subject.course_assets.try(:first)
        if @course_asset
          redirect_to send("course_asset_#{CourseAssetModelType.find_by_id(@course_asset.model_type).name_of_model}_path", @course_asset, @query_string)
        else
          redirect_to subject_path(@subject)
        end
      else
        @subject = Subject.find_by_id(params[:subject_id])
        @query_string = {:subject_id => @subject.id}
        @choices = @user.subjects.where(:archived => 0)
        @asset_type = "Subject Assets"
        @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
        @course_assets = @subject.course_assets
        @enrolled_assets = @subject.enrollment.try(:course).try(:course_assets)
    		@textbookDels = @course_asset.try(:textbook_delegations)
        
    		if @textbookDels
      		@textbookDels_current  = @textbookDels.where(:archived => 0).order(:position)
      		@textbookDels_archived = @textbookDels.where(:archived => 1).order(:position)
      		@textbookDels_future   = @textbookDels.where(:archived => 2).order(:position)
      		if (@textbookDels.count == 0)
      			@ujsAlert = "No textbooks are currently assigned."
      		else
      			@ujsAlert = nil
      		end
    		end
        @assetable = @subject
      end
            
    else
      
      # user must be a parent (@user_mode == :parent)
      
      # ***** TO BE COMPLETED *****
      
    end
 
  end
  
  
end
