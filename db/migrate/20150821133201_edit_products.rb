class EditProducts < ActiveRecord::Migration
  def change
    add_column :products, :provider, :string
    add_column :products, :url, :string
    add_column :products, :pretty_url, :string
  end
end
