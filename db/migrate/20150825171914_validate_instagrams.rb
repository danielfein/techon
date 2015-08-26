class ValidateInstagrams < ActiveRecord::Migration
    def change
      create_table :validate_instagrams do |t|
        t.integer :uid
        t.timestamp :time
        t.integer :before
        t.string :url
        t.integer :url_id
        t.integer :awarded
        t.timestamps null: false
        t.integer :product_id
  
      end
    end
end
