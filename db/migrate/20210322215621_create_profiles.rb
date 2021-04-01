class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :last_name
      t.string :address
      t.integer :document
      t.string :type_document
      t.string :phone
      t.string :state
      t.string :city
      t.string :gender
      t.string :age
      t.datetime :date_of_birth
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
