class ChargesController < ApplicationController 
	def new
	end

	def create
	  # Amount in cents
	  @amount = 500

	  customer = Stripe::Customer.create(
	    :email => 'example@stripe.com',
	    :card  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => 2 * @amount,
	    :description => 'Rails Stripe customer',
	    :currency    => 'usd',
	    #:capture 	 => false
	  )
	  	@pledge = current_student.pledges.build(pledge_params)
	  	@campaign = Campaign.find(params[:campaign_id])
	  	@pledge.campaign = @campaign
	  	@pledge.stripe_charge_id = charge["id"]
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
	      flash[:notice] = 'Pledge created!   ($' + @pledge.amount.to_s + ')'
	      #redirect_to :back
     	else
         flash[:alert] = 'Invalid pledge amount!   ($' + @pledge.amount.to_s + ')'
	      #redirect_to :back
      end

		# transfer = Stripe::Transfer.create(
		#   :amount => @amount, # amount in cents
		#   :currency => "usd",
		#   :recipient => "rp_15u7AhBHXitMUPPCDfMZTkA2",
		#   :bank_account => "ba_15u8A6BHXitMUPPCSpIuciCT",
		#   :statement_descriptor => "test transfer"
		# )

		rescue Stripe::CardError => e
		  flash[:error] = e.message
		  #redirect_to :back
	end

	private

	    def pledge_params
	      params.require(:pledge).permit(:amount, :status)
	    end
	end
