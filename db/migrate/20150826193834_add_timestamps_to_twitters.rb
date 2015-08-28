class AddTimestampsToTwitters < ActiveRecord::Migration
  def change
    add_column :validate_twitters, :created_at, :timestamp
    add_column :validate_twitters, :updated_at, :timestamp
  end
end
