class RemovePhotoFromRushees < ActiveRecord::Migration
  def change
   remove_column :rushees, :photo_file_name
   remove_column :rushees, :photo_content_type
   remove_column :rushees, :photo_file_size
   remove_column :rushees, :photo_updated_at
  end
end
