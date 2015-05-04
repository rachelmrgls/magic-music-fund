module ApplicationHelper
	def username
    	@username = session[:cas_user]
  	end
end
