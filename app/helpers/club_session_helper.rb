module ClubSessionHelper
    # Logs in the given user.
    def club_log_in(club)
      session[:club_id] = club.id
    end

    # Returns the current logged-in club (if any).
    def current_club
      @current_club ||= Club.find_by(id: session[:club_id])
    end

    # Returns true if the given user is the current user.
    def current_club?(club)
      club == current_club
    end

    # Returns true if the user is logged in, false otherwise.
    def club_logged_in?
      !current_club.nil?
    end

    # Logs out the current club.
    def club_log_out
      session.delete(:club_id)
      @current_club = nil
    end

    def club_logged_out?
      current_club.nil?
    end

end
