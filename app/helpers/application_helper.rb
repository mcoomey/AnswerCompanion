module ApplicationHelper
	
	def current_user
		(current_student || current_instructor)
	end
	
	def current_user_email
		if instructor_signed_in?
			current_instructor.email
		elsif student_signed_in?
			current_student.email
		else
			"Not signed in"
		end
	end  	
	
	def destroy_user_session_path
		if instructor_signed_in? 
			return destroy_instructor_session_path
		elsif student_signed_in? 
			return destroy_student_session_path 
		end		
	end
	
end
