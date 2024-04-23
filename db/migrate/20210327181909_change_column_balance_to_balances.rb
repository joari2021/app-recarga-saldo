class ChangeColumnBalanceToBalances < ActiveRecord::Migration[6.1]
  def change
    remove_column :balances, :balance
    add_column :balances, :balance, :decimal, precision: 18, scale: 2
  end
end
