class CreateInsurancePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :insurance_plans do |t|
      t.string :name
      t.decimal :price
      t.string :class

      t.timestamps
    end
  end
end
