class ChangeActiveDefaultOnUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_default :users, :active, from: false, to: true
  end
end
