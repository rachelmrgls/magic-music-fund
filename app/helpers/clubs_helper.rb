module ClubsHelper
	 def has_stripe?(club)
      club.recipient_id != nil # is it nil or is it ""
    end
end
