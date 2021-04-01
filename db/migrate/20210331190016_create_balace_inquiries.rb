class CreateBalaceInquiries < ActiveRecord::Migration[6.1]
  def change
    create_table :balace_inquiries do |t|
      t.decimal :debt, precision: 18, scale:2
      t.string :avalaible_days
      t.string :operator
      t.string :cod_area
      t.string :phone
      t.string :status, default: "en proceso"

      t.timestamps
    end
  end
end
