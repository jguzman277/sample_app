class AddAdminAndActiveToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :admin, :boolean
    add_column :users, :active, :boolean
  end
end
