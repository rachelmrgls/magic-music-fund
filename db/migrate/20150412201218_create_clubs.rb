class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :email
      t.string :password
      t.integer :tiltAccNum
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
