class CreateRechargeParams < ActiveRecord::Migration[6.1]
  def change
    create_table :recharge_params do |t|
      t.string :operadora
      t.integer :amount_min
      t.integer :amount_max
      t.string :multiplos_amount_permit

      t.timestamps
    end
  end
end
