class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.references :user, index: true, foreign_key: true
      t.string :provider
      t.string :access_token
      t.string :access_token_secret
      t.string :provider_id

      t.timestamps null: false
    end
  end
end
