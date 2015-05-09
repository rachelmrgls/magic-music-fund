class AddBankToClubs < ActiveRecord::Migration
  def change
  	add_column :clubs, :has_bank, :integer, :default => 0
  end
end
