require 'net/http'
require 'net/https'
require 'uri'

class PledgesController < ApplicationController
	before_action :logged_in_student, only: [:create, :destroy]

	def create
	 	@campaign = Campaign.find(params[:campaign_id])
		@pledge = current_student.pledges.build(pledge_params)
		@email = current_student.netid
	  customer = Stripe::Customer.create(
	    :email => @email,
	    :card  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => (@pledge.amount.to_i * 100),
	    :description => @campaign.club.name,
	    :currency    => 'usd',
	    :capture 	 => false
	  )

		@pledge.campaign = @campaign
		@pledge.status = 1
		@pledge.stripe_charge_id = charge["id"]
		
    if @pledge.save
      stripe_amount = (@pledge.amount*0.971 - 0.3)
      @campaign.currentMoney += stripe_amount
      @campaign.save
      @campaign.pledges << @pledge
      updated_money = (@campaign.goalMoney+0.25)
      if (@campaign.currentMoney + @campaign.clubMoney >= updated_money)
      	@campaign.completed = 1
      	@campaign.save
      	#@campaign.complete_campaign
      	@campaign.pledges.each do |pledge|
		  	pledge.status = 0
		  	ch = Stripe::Charge.retrieve(pledge.stripe_charge_id)
		  	ch.capture
		  	pledge.save
			end
		# need to add recipient id to club 
		#recipient_id = Club.find(@campaign.club_id).recipient_id.to_s
		#rp = Stripe::Recipient.retrieve(recipient_id)
		#bank_account_id = rp["bank_account"]["id"]
		transfer = Stripe::Transfer.create(
		  :amount => @campaign.goalMoney*100 - @campaign.clubMoney*100, # amount in cents
		  :currency => "usd",
		  :recipient => "rp_15u7AhBHXitMUPPCDfMZTkA2",
		  :bank_account => "ba_15u8A6BHXitMUPPCSpIuciCT",
		  :statement_descriptor => "cannon transfer"
		)
 	 	end
    end
    redirect_to @campaign
	end

	def destroy
  end

  private

  def pledge_params
    params.require(:pledge).permit(:amount, :status)
  end
end
