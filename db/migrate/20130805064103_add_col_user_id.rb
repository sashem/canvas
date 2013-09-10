class AddColUserId < ActiveRecord::Migration
  def change
    add_column :datos, :user_id, :integer
  end
end
