module ApplicationHelper
	
	def current_user
		(current_student || current_instructor || current_parent)
	end
	
	def current_user_email
		if instructor_signed_in?
			current_instructor.email
		elsif student_signed_in?
			current_student.email
		elsif parent_signed_in?
			current_student.email
		else
			"Not signed in"
		end
	end  	
	
	def edit_user_registration_path
	 	if instructor_signed_in? 
			return edit_instructor_registration_path
		elsif student_signed_in? 
			return edit_student_registration_path
		elsif parent_signed_in? 
			return edit_parent_registration_path
		end		
	end
	
	def destroy_user_session_path
		if instructor_signed_in? 
			return destroy_instructor_session_path
		elsif student_signed_in? 
			return destroy_student_session_path
		elsif parent_signed_in? 
			return destroy_parent_session_path
		end		
	end
	
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render("shared/" + association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end

end
