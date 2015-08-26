class ChangeProviderId < ActiveRecord::Migration
  def change
        rename_column :products, :facebook_id, :provider_id
  end
end
