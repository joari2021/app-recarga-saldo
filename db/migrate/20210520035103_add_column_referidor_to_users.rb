class AddColumnReferidorToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :user_referidor_id, :string
    add_column :users, :referidor_id, :string
  end
end
