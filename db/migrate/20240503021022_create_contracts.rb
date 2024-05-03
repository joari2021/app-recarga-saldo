class CreateContracts < ActiveRecord::Migration[6.1]
  def change
    create_table :contracts do |t|
      t.references :client, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true
      t.references :insurance_plan, null: false, foreign_key: true
      t.integer :usage
      t.integer :ramo
      t.integer :coverage1
      t.integer :coverage2
      t.integer :coverage3
      t.integer :year
      t.string :placa
      t.string :tipo
      t.string :serial_carroceria
      t.string :serial_motor
      t.string :color
      t.integer :puestos

      t.timestamps
    end
  end
end
