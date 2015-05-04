require 'casclient'
require 'casclient/frameworks/rails/filter'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter CASClient::Frameworks::Rails::Filter

  self.allow_forgery_protection = false
  #protect_from_forgery with: :exception
  include SessionsHelper
  include ClubSessionHelper


  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end

  private

    # Confirms a logged-in student.
    def logged_in_student
      unless student_logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to student_login_url
      end
    end

    # Confirms a logged-in club.
    def logged_in_club
      unless club_logged_in?
        store_location
        flash[:danger] = "Please log in your club."
        redirect_to home_url
      end
    end

end
