class TwitterInfo < ActiveRecord::Migration
  def change
    add_column :users, :screen_name, :string
    add_column :users, :name, :string
    add_column :users, :nickname, :string
    add_column :users, :website, :string
    add_column :users, :twitter_link, :string
    add_column :users, :description, :string
  end
end
