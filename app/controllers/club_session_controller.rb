class ClubSessionController < ApplicationController
  def new
  end

  def create
    club = Club.find_by(email: params[:club_session][:email].downcase)
    # puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    # puts club.password
    puts params[:club_session][:password]
    if club && club.authenticate(params[:club_session][:password])
      # Log the user in and redirect to the user's show page.
      club_log_in club
      redirect_to club
    else
      flash[:danger] = 'Invalid club email/password combination' # Not quite right!
      #render 'new'
      redirect_to home_url
    end
  end

  def destroy
    club_log_out
    redirect_to home_url
  end
end
