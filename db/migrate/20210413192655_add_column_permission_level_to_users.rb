class AddColumnPermissionLevelToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :permission_level, :integer, default: 1
  end
end
