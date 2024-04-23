class ChangesCamposToDeposits < ActiveRecord::Migration[6.1]
  def change
    add_column :deposits, :day_payment, :integer
    add_column :deposits, :month_payment, :integer
    add_column :deposits, :year_payment, :integer
    add_column :deposits, :bank_destinity, :string

    rename_column :deposits, :phone, :method_payment
    add_column :deposits, :ref_payment, :string
    
    remove_column :deposits, :status, :string
    add_column :deposits, :status, :string, default: "Diferido"
  end
end
