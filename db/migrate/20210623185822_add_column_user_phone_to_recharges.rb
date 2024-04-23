class AddColumnUserPhoneToRecharges < ActiveRecord::Migration[6.1]
  def change
    add_column :recharges, :user_phone, :string
  end
end
