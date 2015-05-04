class Campaign < ActiveRecord::Base
	has_many :pledges
	belongs_to :club

	mount_uploader :picture, PictureUploader
	validate  :picture_size

	validates_numericality_of :clubMoney
  	validates_numericality_of :goalMoney, :greater_than => :clubMoney
  	validate  :end_date_check

  	def complete_campaign
  		completed = 1
  	end

	private

	    # Validates the size of an uploaded picture.
	    def picture_size
	      if picture.size > 5.megabytes
	        errors.add(:picture, "should be less than 5MB")
	      end
	    end

	    def end_date_check
	      if start_date.to_time.to_i >= end_date.to_time.to_i
	        errors.add(:end_date, "must be later than start date") 
	      end

	      if (end_date > start_date+7.days)
	      # if (end_date.to_time.to_i - start_date.to_time.to_i) > 7
	      	errors.add(:end_date, "cannot be more than 7 days later than start date")
	      end
	    end

end
