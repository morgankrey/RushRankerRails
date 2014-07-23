class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :user_id
      t.integer :rushee_id

      t.timestamps
    end
    add_index :relationships, :user_id
    add_index :relationships, :rushee_id
    add_index :relationships, [:user_id, :rushee_id], unique: true
  end
end
