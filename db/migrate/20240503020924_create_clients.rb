class CreateClients < ActiveRecord::Migration[6.1]
  def change
    create_table :clients do |t|
      t.string :nombres
      t.string :apellidos
      t.string :rif_o_cedula
      t.string :direccion
      t.string :telefono
      t.string :estado_civil
      t.string :email
      t.string :ocupacion

      t.timestamps
    end
  end
end
