class FacebookId < ActiveRecord::Migration
  def change
        add_column :products, :facebook_id, :string
  end
end
