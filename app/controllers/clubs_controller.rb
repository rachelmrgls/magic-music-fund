class ClubsController < ApplicationController
  before_action :logged_in_club, only: [:show, :index, :edit, :update, :destroy]
  before_action :correct_club,   only: [:show, :edit, :update]

  def show
    @club = Club.find(params[:id])
  end

  def new
  	@club = Club.new
  end

  # GET /clubs/1/edit
  def edit
    @club = Club.find(params[:id])
  end

  def live
    @club = Club.find(params[:id])
  end

  def create
    @club = Club.new(club_params)    # Not the final implementation!

    #respond_to do |format|
    #  if @club.save
    #    format.html { redirect_to login_url, notice: 'Club was successfully created.' }
    #    format.json { render :show, status: :created, location: @club }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @club.errors, status: :unprocessable_entity }
    #  end
    #end

    if @club.save
      club_log_in @club
      # Handle a successful save.
      flash[:success] = "Welcome to your club page!"
      redirect_to @club
    else
      render 'new'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club
      @club = Club.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def club_params
      params.require(:club).permit(:name, :email, :password, :tiltAccNum, :recipient_id)
    end

    # Confirms the correct club.
    def correct_club
      @club = Club.find(params[:id])
      redirect_to(home_url) unless current_club?(@club)
    end
end
