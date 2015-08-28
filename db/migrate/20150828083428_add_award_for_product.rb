class AddAwardForProduct < ActiveRecord::Migration
  def change
    add_column :credit_plans, :award_credits, :integer

  end
end
