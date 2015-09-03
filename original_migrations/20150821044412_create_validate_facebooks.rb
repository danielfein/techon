class CreateValidateFacebooks < ActiveRecord::Migration
  def change
    create_table :validate_facebooks do |t|
      t.integer :uid
      t.timestamp :time
      t.integer :before
      t.string :url
      t.integer :url_id

      t.timestamps null: false
    end
  end
end
