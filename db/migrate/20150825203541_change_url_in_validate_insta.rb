class ChangeUrlInValidateInsta < ActiveRecord::Migration
  def change
      rename_column :validate_instagrams, :url, :username
  end
end
