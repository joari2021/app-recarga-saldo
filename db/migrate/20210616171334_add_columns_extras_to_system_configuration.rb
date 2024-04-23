class AddColumnsExtrasToSystemConfiguration < ActiveRecord::Migration[6.1]
  def change
    add_column :system_configurations, :usuarios_extras, :integer, :default => 0
    add_column :system_configurations, :recargas_extras, :integer, :default => 0
  end
end
