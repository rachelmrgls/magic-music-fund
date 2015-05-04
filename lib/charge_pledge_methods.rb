module CommonStuff
  def pledge_create
    @campaign = Campaign.find(params[:campaign_id])
		@pledge = current_student.pledges.build(pledge_params)
		@pledge.campaign = @campaign
		@pledge.status = 1
		
	    if @pledge.save
	      @campaign.currentMoney += @pledge.amount
	      @campaign.save
	      @campaign.pledges << @pledge
	      if (@campaign.currentMoney + @campaign.clubMoney >= @campaign.goalMoney)
	      	@campaign.pledges.each do |pledge|
  			  	pledge.status = 0
  			  	pledge.save
					end
		 	 	end
	      flash[:notice] = 'Pledge created!' 
	      redirect_to :back
     	else
          flash[:alert] = 'Invalid pledge amount!   ($' + @pledge.amount.to_s + ')'
	      redirect_to :back
      end
  end
end