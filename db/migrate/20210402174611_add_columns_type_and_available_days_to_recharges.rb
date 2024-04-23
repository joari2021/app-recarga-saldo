class AddColumnsTypeAndAvailableDaysToRecharges < ActiveRecord::Migration[6.1]
  def change
    add_column :recharges, :type_operation, :string, default: "direct_recharge"
    add_column :recharges, :available_days, :integer
  end
end
