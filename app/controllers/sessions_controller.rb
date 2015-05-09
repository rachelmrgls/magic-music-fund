class SessionsController < ApplicationController
  def new
  end


  def create
    student = Student.find_by(netid: params[:student_session][:netid])
    #if username
     #   redirect_to home_url

    if student
      # Log the user in and redirect to the user's show page.
      student_log_in student
      # remember student
      redirect_to home_url
    else
      # Create new student account.
      @student = Student.new(student_params)
      if @student.save
        flash.now[:notice] = 'Student successfully created'
        student_log_in @student
        redirect_to home_url
      else
        flash.now[:danger] = 'Student could not be created'
        redirect_to student_login_url
      end
    end
  end

  def destroy
    club_log_out if club_logged_in?
    student_log_out if student_logged_in?
    redirect_to student_login_url
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student_session).permit( :netid, :tiltAccNum)
    end

    # Confirms the correct student.
    def correct_student
      @student = Student.find(params[:id])
      redirect_to(home_url) unless current_student?(@student)
    end
end



