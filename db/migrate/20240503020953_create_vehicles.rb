class CreateVehicles < ActiveRecord::Migration[6.1]
  def change
    create_table :vehicles do |t|
      t.string :nombres
      t.string :apellidos
      t.string :rif_o_cedula

      t.timestamps
    end
  end
end
