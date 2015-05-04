module PledgesHelper
	def status?(pledge)
		if pledge.status == 0
			return "Charged"
		end
		if pledge.status == 1
			return "Pending"
		else 
			return "Expired"
		end
	end
end
