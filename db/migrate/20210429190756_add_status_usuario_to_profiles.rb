class AddStatusUsuarioToProfiles < ActiveRecord::Migration[6.1]
  def change
    add_column :profiles, :status_usuario, :string, default: "activo"
  end
end
