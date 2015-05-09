module SessionsHelper
	def student_log_in(student)
		session[:student_id] = student.id
	end

	  # Remembers a user in a persistent session.
  	# def remember(student)
	  #   student.remember
	  #   cookies.permanent.signed[:student_id] = student.id
	  #   cookies.permanent[:remember_token] = student.remember_token
	  # end

	def current_student
		@current_student ||= Student.find_by(id: session[:student_id])
	end

	def student_logged_in?
		!current_student.nil?
	end

	# Returns true if the given user is the current user.
  	def current_student?(student)
    	student == current_student
  	end

	def student_log_out
		session.delete(:student_id)
		@current_student = nil
	end

	# Redirects to stored location (or to the default).
  	def redirect_back_or(default)
    	redirect_to(session[:forwarding_url] || default)
    	session.delete(:forwarding_url)
  	end

  	# Stores the URL trying to be accessed.
  	def store_location
    	session[:forwarding_url] = request.url if request.get?
 	end


end
