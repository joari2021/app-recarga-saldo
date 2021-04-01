class CreateBalances < ActiveRecord::Migration[6.1]
  def change
    create_table :balances do |t|
      t.decimal :balance
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
