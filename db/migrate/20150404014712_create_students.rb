class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :netid
      t.integer :tiltAccNum

      t.timestamps null: false
    end
  end
end
