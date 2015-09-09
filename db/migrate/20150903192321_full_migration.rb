class FullMigration < ActiveRecord::Migration
   def change


      #Credits
      create_table :credits do |t|
         t.integer :uid
         t.integer :balance, default: 50, null: false
         t.timestamps null: false
      end

      #Transactions
      create_table :transactions do |t|
         t.integer :sender_uid
         t.integer :recipient_uid
         t.integer :payment_amount
         t.string :provider_type
         t.timestamps null: false
         t.integer :product_id
      end

      #Products
      create_table :products do |t|
         t.integer :owner_uid
         t.string :name
         t.integer :price
         t.timestamps null: false
         t.string :url
   t.string :pretty_url
         t.string :provider
         t.integer :is_active, default: 1

         t.string :provider_id
         t.string :cover_photo
         t.string :profile_pic

      end

      #Creating Users with Devise:
      create_table(:users) do |t|
         t.string :name
         t.string :nickname
         t.string :description

         ## Database authenticatable
         t.string :email,              null: false, default: ""
         t.string :encrypted_password, null: false, default: ""

         ## Recoverable
         t.string   :reset_password_token
         t.datetime :reset_password_sent_at

         ## Rememberable
         t.datetime :remember_created_at

         ## Trackable
         t.integer  :sign_in_count, default: 0, null: false
         t.datetime :current_sign_in_at
         t.datetime :last_sign_in_at
         t.string   :current_sign_in_ip
         t.string   :last_sign_in_ip

         ## Confirmable
         # t.string   :confirmation_token
         # t.datetime :confirmed_at
         # t.datetime :confirmation_sent_at
         # t.string   :unconfirmed_email # Only if using reconfirmable

         ## Lockable
         # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
         # t.string   :unlock_token # Only if unlock strategy is :email or :both
         # t.datetime :locked_at


         t.timestamps null: false
      end

      add_index :users, :email,                unique: true
      add_index :users, :reset_password_token, unique: true
      # add_index :users, :confirmation_token,   unique: true
      # add_index :users, :unlock_token,         unique: true

      #Create Facebook Validation
      create_table :validate_facebooks do |t|
         t.integer :uid
         t.integer :before
         t.string  :url
         t.integer :product_id
         t.integer :awarded, default: 0
         t.integer :balance
         t.timestamps null: false
      end

      #Create Instagram Validation

      create_table :validate_instagrams do |t|
         t.integer :uid
         t.integer :before
         t.string  :username
         t.integer :url_id
         t.integer :awarded, default: 0
         t.integer :product_id
         t.integer :balance
         t.timestamps null: false
      end

      #Create Twitter Validation
      create_table :validate_twitters do |t|
         t.integer :uid
         t.integer :before
         t.string  :url
         t.integer :url_id
         t.integer :awarded, default: 0
         t.integer :product_id
         t.string  :username
         t.integer :balance
         t.timestamps null: false
      end

      #Create Credit Plan for Stripe
      create_table :credit_plans do |t|
         t.integer :price
         t.string :permalink
         t.string :name

         t.integer :award_credits
         t.timestamps null: false
      end

      #Create identities
      create_table :identities do |t|
         t.references :user, index: true, foreign_key: true
         t.string :provider
         t.string :access_token
         t.string :access_token_secret
         t.string :provider_id
         t.timestamps null: false
      end
      
      create_table :skips do |t|
         t.integer :uid
         t.integer :product_id
      end

   end
end
