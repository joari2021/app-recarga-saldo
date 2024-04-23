class CreateSystemConfigurations < ActiveRecord::Migration[6.1]
  def change
    create_table :system_configurations do |t|
      t.boolean :movistar, :default => false
      t.boolean :digitel, :default => false
      t.boolean :movilnet, :default => false
      t.boolean :cantv, :default => false
      t.boolean :movistar_tv, :default => false
      t.boolean :inter, :default => false
      t.boolean :simple_tv, :default => false
      t.decimal :dolar_bcv, :precision => 18, :scale => 2

      t.timestamps
    end
  end
end
