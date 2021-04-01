class ChangeColumnsToRecharges < ActiveRecord::Migration[6.1]
  def change
    remove_column :recharges, :amount, :integer

    add_column :recharges, :amount, :decimal, precision: 18, scale: 2
    add_column :recharges, :type_payment, :string
    add_column :recharges, :status, :string, default: "enviada"
  end
end
