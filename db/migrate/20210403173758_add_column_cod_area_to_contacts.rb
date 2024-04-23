class AddColumnCodAreaToContacts < ActiveRecord::Migration[6.1]
  def change
    remove_column :contacts, :alias, :string

    add_column :contacts, :cod_area, :string
    add_column :contacts, :operator, :string
    add_column :contacts, :type_payment, :string
  end
end
