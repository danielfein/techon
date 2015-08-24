class Awarded < ActiveRecord::Migration
  def change
        add_column :validate_facebooks, :awarded, :integer, :default => 0
  end
end
