class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :score, default: 0
      t.integer :rushee_id

      t.timestamps
    end
    add_index :scores, :rushee_id
  end
end
