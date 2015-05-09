module ClubsHelper 
	def has_stripe?(club)
      club.recipient_id != nil # is it nil or is it ""
    end
    def has_bank_account?(club)
    	club.has_bank == 1
    end
end
