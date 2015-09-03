class AddBalance < ActiveRecord::Migration
  def change
     add_column :validate_facebooks, :balance, :integer
    add_column :validate_instagrams, :balance, :integer
   add_column :validate_twitters, :balance, :integer
  end
end
