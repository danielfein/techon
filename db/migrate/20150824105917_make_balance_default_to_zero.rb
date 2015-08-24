class MakeBalanceDefaultToZero < ActiveRecord::Migration
  def change
    change_column :credits, :balance, :integer, :default => 0, :null => false
  end
end
