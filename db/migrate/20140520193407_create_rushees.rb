class CreateRushees < ActiveRecord::Migration
  def change
    create_table :rushees do |t|
      t.string :first_name
      t.string :last_name
      t.string :preferred_name
      t.string :phone_number
      t.string :email
      t.string :hometown
      t.string :state
      t.string :high_school
      t.string :grade
      t.integer :score, default: 0

      t.timestamps
    end
    add_index :rushees, :created_at
    add_index :rushees, :email, unique: true
  end
end
