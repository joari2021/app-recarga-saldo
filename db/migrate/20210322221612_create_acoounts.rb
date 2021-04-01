class CreateAcoounts < ActiveRecord::Migration[6.1]
  def change
    create_table :acoounts do |t|
      t.string :bank
      t.integer :document
      t.string :type_document
      t.string :number_account
      t.string :phone
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
