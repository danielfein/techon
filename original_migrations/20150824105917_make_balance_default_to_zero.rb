class MakeBalanceDefaultToZero < ActiveRecord::Migration
  def change
    change_column :credits, :balance, :integer, :default => 50, :null => false
  end
end
