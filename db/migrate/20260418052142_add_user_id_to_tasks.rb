class AddUserIdToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :user_id, :integer, null: false, default: 1
    add_index :tasks, :user_id
  end
end