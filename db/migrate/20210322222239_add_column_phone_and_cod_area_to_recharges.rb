class AddColumnPhoneAndCodAreaToRecharges < ActiveRecord::Migration[6.1]
  def change
    add_column :recharges, :phone, :string
    add_column :recharges, :cod_area, :string
  end
end
