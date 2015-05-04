class AddClubToCampaign < ActiveRecord::Migration
  def change
    add_reference :campaigns, :club, index: true, foreign_key: true
  end
end
