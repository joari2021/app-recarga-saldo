class CreateNonexistentNumbers < ActiveRecord::Migration[6.1]
  def change
    create_table :nonexistent_numbers do |t|
      t.string :operator
      t.string :type_payment
      t.string :number

      t.timestamps
    end
  end
end
