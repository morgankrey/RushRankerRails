class RemoveScoreFromRushees < ActiveRecord::Migration
  def change
    remove_column :rushees, :score, :integer
  end
end
