class CreateCredits < ActiveRecord::Migration
  def change
    create_table :credits do |t|
      t.integer :uid
      t.integer :balance

      t.timestamps null: false
    end
  end
end
