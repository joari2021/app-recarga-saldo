class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :names
      t.string :alias
      t.string :phone
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
