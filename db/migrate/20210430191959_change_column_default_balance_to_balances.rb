class ChangeColumnDefaultBalanceToBalances < ActiveRecord::Migration[6.1]
  def change
    change_column :balances, :balance, :decimal, default: 0.0
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
