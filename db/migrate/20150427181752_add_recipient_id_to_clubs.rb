class AddRecipientIdToClubs < ActiveRecord::Migration
  def change
  	add_column :clubs, :recipient_id, :string
  end
end
