module CampaignsHelper
	def percent(campaign)
		@fraction = campaign.currentMoney / (campaign.goalMoney.to_i - campaign.clubMoney.to_i)
		if @fraction < 1
			return @fraction * 100
		else
			return 100
		end
	end

	def campaign_completed?(campaign)
		campaign.completed == 1
	end
end
