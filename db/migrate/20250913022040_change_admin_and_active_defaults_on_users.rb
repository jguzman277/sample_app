class ChangeAdminAndActiveDefaultsOnUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_default :users, :admin, from: nil, to: false
    change_column_default :users, :active, from: nil, to: false
  end
end
