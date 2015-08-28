class CreateCreditPlans < ActiveRecord::Migration
  def change
    create_table :credit_plans do |t|
      t.integer :price
      t.string :permalink
      t.string :name

      t.timestamps null: false
    end
  end
end
