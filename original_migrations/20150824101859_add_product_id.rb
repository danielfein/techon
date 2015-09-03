class AddProductId < ActiveRecord::Migration
  def change
        add_column :validate_facebooks, :product_id, :integer
  end
end
