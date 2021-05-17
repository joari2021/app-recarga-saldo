class AddColumnsFaltToRecharges < ActiveRecord::Migration[6.1]
  def change
    add_column :recharges, :saldo_resultante, :decimal, :precision => 18, :scale => 2
    add_column :recharges, :renta_mensual, :decimal, :precision => 18, :scale => 2
    add_column :recharges, :number_inexistente, :boolean, :default => false
  end
end
