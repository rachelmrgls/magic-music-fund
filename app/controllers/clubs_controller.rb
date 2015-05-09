class ClubsController < ApplicationController 
  include ClubsHelper 
  before_action :logged_in_club, only: [:show, :index, :edit, :update, :destroy]
  before_action :correct_club,   only: [:show, :edit, :update]

  def show
    @club = Club.find(params[:id])
  end

  def new
  	@club = Club.new
  end

  def update
    if (params[:update_id] .eql? "bank")
      Stripe.api_key = 'sk_test_6fMKKvnEUkQIMYsCSj2WlqHb'
      bank = Stripe::Token.create(
        :bank_account => {
        :country => "US",
        :routing_number => params[:routingNum],
        :account_number => params[:accountNum], 
        },
      )
      rp = Stripe::Recipient.retrieve(current_club.recipient_id)
      rp.bank_account = bank["id"]
      rp.save
      current_club.update_attribute :has_bank, 1
      redirect_to current_club
    # elsif (params[:update_id] .eql? "password")
    #   if (params[:old_password] == current_club.password)
    #     puts "~~~~~~~~~~~$$$$$$$$$~~~~~~~~~~~~~~~~"
    #     puts params[:new_password]
    #     current_club.update_attribute :password, params[:new_password]
    #     redirect_to current_club
    #   else
    #     flash[:notice] = "Current password is invalid"
    #   end
    end 
  end

  # GET /clubs/1/edit
  def edit
    @club = Club.find(params[:id])
  end

  def live
    @club = Club.find(params[:id])
  end

  def create
    
    if (current_club == nil)
      @club = Club.new(club_params)    # Not the final implementation!

      if @club.save
        club_log_in @club
        # Handle a successful save.
        flash[:success] = "Welcome to your club page!"
        redirect_to @club
      else
        render 'new'
      end
    else 
      self.update
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_club
      @club = Club.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def club_params
      params.require(:club).permit(:name, :email, :password, :routingNum, :accountNum, :recipient_id, :has_bank)
    end

    # Confirms the correct club.
    def correct_club
      @club = Club.find(params[:id])
      redirect_to(home_url) unless current_club?(@club)
    end
end