class RenameColumnToRecharges < ActiveRecord::Migration[6.1]
  def change
    rename_column :recharges, :phone, :number
    rename_column :contacts, :phone, :number
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
