class AddUserRefToPosts < ActiveRecord::Migration[8.0]
  def change
    first_user_id = User.first.id

    add_reference :posts, :user, null: false, foreign_key: true, default: first_user_id
  end
end
