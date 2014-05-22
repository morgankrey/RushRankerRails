class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :user_id
      t.integer :rushee_id

      t.timestamps
    end
    add_index :comments, [:rushee_id, :created_at]
  end
end
