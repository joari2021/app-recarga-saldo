class AddColumnStateToRechargesAndDeposits < ActiveRecord::Migration[6.1]
  def change
    add_column :recharges, :state, :string, :default => "ontried"
    add_column :deposits, :state, :string, :default => "ontried"
  end
end
