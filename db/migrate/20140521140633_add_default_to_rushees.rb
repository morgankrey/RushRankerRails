class AddDefaultToRushees < ActiveRecord::Migration
  def change
    change_column :rushees, :score, :integer, default: 0
  end
end
