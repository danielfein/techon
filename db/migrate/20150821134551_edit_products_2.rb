class EditProducts2 < ActiveRecord::Migration
  def change
    add_column :products, :owner_uid, :integer
    add_column :products, :is_active, :integer
  end
end
