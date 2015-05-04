class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.integer :goalMoney
      t.integer :clubMoney
      t.integer :currentMoney
      t.date :start
      t.date :end
      t.text :description

      t.timestamps null: false
    end
  end
end
