class AddCompletedToCampaigns < ActiveRecord::Migration
  def change
  	add_column :campaigns, :completed, :integer, :default => 0
  end
end
