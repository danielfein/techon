class FbCover < ActiveRecord::Migration
  def change
   add_column :products, :cover_photo, :string
   add_column :products, :profile_pic, :string
   change_column_default :products, :is_active, 1
   remove_column :products, :description
  end
end
