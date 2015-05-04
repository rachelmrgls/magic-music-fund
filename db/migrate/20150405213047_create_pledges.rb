class CreatePledges < ActiveRecord::Migration
  def change
    create_table :pledges do |t|
      t.integer :amount
      t.integer :status
      t.references :student, index: true
      t.references :campaign, index: true

      t.timestamps null: false
    end
    add_foreign_key :pledges, :students
    add_foreign_key :pledges, :campaigns
    add_index :pledges, [:student_id, :created_at]
    add_index :pledges, [:campaign_id, :created_at]
  end
end
