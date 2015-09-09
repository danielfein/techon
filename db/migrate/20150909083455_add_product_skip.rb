class AddProductSkip < ActiveRecord::Migration
  def change

     create_table :skips do |t|
        t.integer :uid
        t.integer :product_id
     end

  end
end
