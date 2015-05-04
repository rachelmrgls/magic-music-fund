class CampaignsController < ApplicationController
  before_action :set_campaign, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_student, only: [:index, :edit, :update, :destroy]
  before_action :logged_in_club, only: [:new]
  #before_action :correct_student,   only: [:show, :edit, :update]  
  # GET /campaigns
  # GET /campaigns.json
  def index
    #redirect_to CASClient::Frameworks::Rails::Filter.redirect_to_cas_for_authentication(self)
    @campaigns = Campaign.all
  end

  # GET /campaigns/1
  # GET /campaigns/1.json
  def show
      @campaign = Campaign.find(params[:id])
      @pledges = @campaign.pledges.paginate(page: params[:page])
  end

  # GET /campaigns/new
  def new
    @campaign = Campaign.new
  end

  # GET /campaigns/1/edit
  def edit
  end

  # POST /campaigns
  # POST /campaigns.json
  def create
    @campaign = current_club.campaigns.build(campaign_params)

    respond_to do |format|
      @campaign.currentMoney = 0
      @campaign.pledges = []
      if @campaign.save
        format.html { redirect_to @campaign, notice: 'Campaign was successfully created.' }
        format.json { render :show, status: :created, location: @campaign }
      else
        format.html { render :new }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /campaigns/1
  # PATCH/PUT /campaigns/1.json
  def update
    respond_to do |format|
      if @campaign.update(campaign_params)
        format.html { redirect_to @campaign, notice: 'Campaign was successfully updated.' }
        format.json { render :show, status: :ok, location: @campaign }
      else
        format.html { render :edit }
        format.json { render json: @campaign.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /campaigns/1
  # DELETE /campaigns/1.json
  def destroy
    @campaign.destroy
    respond_to do |format|
      format.html { redirect_to current_club, notice: 'Campaign was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_campaign
      @campaign = Campaign.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def campaign_params
      params.require(:campaign).permit(:name, :club_name, :goalMoney, :clubMoney, :start_date, :end_date, :picture, :description, :completed)
    end

    # Confirms the correct student.
    def correct_student
      @student = Student.find(params[:id])
      redirect_to(home_url) unless current_student?(@student)
    end
end
