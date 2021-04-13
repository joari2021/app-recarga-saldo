class ChangeColumnsToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :zip_code, :string
    add_column :profiles, :status, :string, default: "incompleto"
  end
end
