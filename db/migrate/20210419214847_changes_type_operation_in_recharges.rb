class ChangesTypeOperationInRecharges < ActiveRecord::Migration[6.1]
  def change
    remove_column :recharges, :type_operation, :string
    add_column :recharges, :type_operation, :string
  end
end
