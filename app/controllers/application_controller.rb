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
    
    puts "**** Current Controller = #{params[:controller]} ****"
    
    if @user_mode == "instructor"
      @choices = @user.courses.where(:archived => 0)
      @asset_type = "Course Assets"
      @sortable_assets = "sortable"
    
      if params[:course] # drop-down menu
        @query_string = {:course_id => params[:course][:id]}
        @course = Course.find_by_id(params[:course][:id])
        @course_assets = @course.course_assets.try(:sort_by, &:position)
        @course_asset = @course.course_assets.try(:first)
        if @course_asset
          redirect_to send("course_asset_#{CourseAssetModelType.find_by_id(@course_asset.model_type).name_of_model}_path", @course_asset, @query_string)
        else
          redirect_to course_path(@course, @query_string)
        end
      else
        if params[:filters]
          @course = Course.find_by_id(params[:filters][:course_id])
        else
          @course = Course.find_by_id(params[:course_id])
        end
        @course_assets = @course.course_assets.try(:sort_by, &:position)
        @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
        @assetable = @course
      end
      
    elsif @user_mode == "student"

      @choices = @user.subjects.where(:archived => 0)
      @asset_type = "Subject Assets"
      @sortable_assets = "not-sortable"
    
      if params[:subject]
        @query_string = {:subject_id => params[:subject][:id]}
        @subject = Subject.find_by_id(params[:subject][:id])
        @course_assets = @subject.course_assets.try(:sort_by, &:position)
        @course_asset = @subject.course_assets.try(:first)
        @enrolled_assets = @subject.enrollment.try(:course).try(:course_assets).try(:sort_by, &:position)
        @enrolled_asset = @enrolled_assets.try(:first)
        if @enrolled_asset
          redirect_to send("course_asset_#{CourseAssetModelType.find_by_id(@enrolled_asset.model_type).name_of_model}_path", @enrolled_asset, @query_string)
        elsif @course_asset
          redirect_to send("course_asset_#{CourseAssetModelType.find_by_id(@course_asset.model_type).name_of_model}_path", @course_asset, @query_string)
        else
          redirect_to subject_path(@subject)
        end
      else
        @subject = Subject.find_by_id(params[:subject_id])
        @course_assets = @subject.course_assets.try(:sort_by, &:position)
        @course_asset = CourseAsset.find_by_id(params[:course_asset_id])
        @enrolled_assets = @subject.enrollment.try(:course).try(:course_assets).try(:sort_by, &:position)
        @assetable = @subject
      end
            
    else
      
      # user must be a parent (@user_mode == :parent)
      # ***** TO BE COMPLETED *****
      
    end
 
  end
  
  
  def set_query_string
    model = controller_name.singularize.to_sym   # .classify.constantize.to_s.downcase
    
    puts "****** model = #{model} ******"
    if params.has_key?(:filters)
      @query_string = {:course_id => params[:filters][:course_id]} if params[:filters][:course_id]
      @query_string = {:subject_id => params[:filters][:subject_id]} if params[:filters][:subject_id]
      @query_string = @query_string.merge({:course_asset_id => params[:filters][:course_asset_id]}) if @query_string && params[:filters][:course_asset_id]
    elsif params.has_key?(model)
      @query_string = {:course_id => params[model][:course_id]} if params[model][:course_id]
      @query_string = {:subject_id => params[model][:subject_id]} if params[model][:subject_id]
      @query_string = @query_string.merge({:course_asset_id => params[model][:course_asset_id]}) if @query_string && params[model][:course_asset_id]
    else
      @query_string = {:course_id => params[:course_id]} if params[:course_id]
      @query_string = {:subject_id => params[:subject_id]} if params[:subject_id]
      @query_string = @query_string.merge({:course_asset_id => params[:course_asset_id]}) if @query_string && params[:course_asset_id]
    end
  
    puts "****** SETTING @query_string TO #{@query_string}******"
    
  end
  
  def load_query_string_vals
    puts "%%%%%%%%%%%%% Loading query string values with @query_string = #{@query_string} %%%%%%%%%%%%%%"
    if @query_string
      @course = Course.find_by_id(@query_string[:course_id]) if @query_string[:course_id]
      @subject = Course.find_by_id(@query_string[:subject_id]) if @query_string[:subject_id]
      @course_asset = Course.find_by_id(@query_string[:course_asset_id]) if @query_string[:course_asset_id]
    end
  end

end
