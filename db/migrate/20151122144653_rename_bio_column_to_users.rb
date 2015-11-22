class RenameBioColumnToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :bio, :biography
  end
end
