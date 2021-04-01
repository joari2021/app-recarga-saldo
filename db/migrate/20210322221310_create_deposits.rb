class CreateDeposits < ActiveRecord::Migration[6.1]
  def change
    create_table :deposits do |t|
      t.decimal :amount
      t.string :bank_origin
      t.string :status
      t.string :phone
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
