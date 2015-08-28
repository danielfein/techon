class CreateValidateTwitters < ActiveRecord::Migration
  def change
    create_table :validate_twitters do |t|
    t.integer :uid
    t.timestamp :time
    t.integer :before
    t.string :url
    t.integer :url_id
    t.integer :awarded, :default => 0
    t.integer :product_id

    end
end

end
