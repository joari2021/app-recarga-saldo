class CreateRecharges < ActiveRecord::Migration[6.1]
  def change
    create_table :recharges do |t|
      t.integer :amount
      t.string :operator
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
