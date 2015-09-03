class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :sender_uid
      t.integer :recipient_uid
      t.integer :payment_amount
      t.timestamp :date_occured
      t.string :provider_type

      t.timestamps null: false
    end
  end
end
