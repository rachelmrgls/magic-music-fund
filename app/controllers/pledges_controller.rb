require 'net/http'
require 'net/https'
require 'uri'

class PledgesController < ApplicationController
	before_action :logged_in_student, only: [:create, :destroy]

	def create
	 	@campaign = Campaign.find(params[:campaign_id])
		@pledge = current_student.pledges.build(pledge_params)
		@email = current_student.netid << "@princeton.edu"
		  
  	customer = Stripe::Customer.create(
	    :email => @email,
	    :card  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => (((@pledge.amount.to_f + 0.30) * 100)/(1-0.029)).ceil,
	    :description => @campaign.club.name,
	    :currency    => 'usd',
	    :capture 	 => false
	  )

	  	#@pledge.amount = (((@pledge.amount.to_f + 0.30))/(1-0.029))
		@pledge.campaign = @campaign
		@pledge.stripe_charge_id = charge["id"]
		
    if @pledge.save
      #stripe_amount = (@pledge.amount*0.971 - 0.3)
      #@campaign.currentMoney += stripe_amount
      @campaign.currentMoney += @pledge.amount
      @campaign.save
      @campaign.pledges << @pledge
      updated_money = @campaign.goalMoney
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
		recipient_id = Club.find(@campaign.club_id).recipient_id.to_s
		rp = Stripe::Recipient.retrieve(recipient_id)
		bank_account_id = rp["active_account"]["id"]
		transfer = Stripe::Transfer.create(
		  :amount => (@campaign.goalMoney*100 - @campaign.clubMoney*100) - 25, 
		  :currency => "usd",
		  :recipient => recipient_id,
 		  :bank_account => bank_account_id,
		  :statement_descriptor => @campaign.club.name
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
