class AddReferencesToBalaceInquiry < ActiveRecord::Migration[6.1]
  def change
    add_reference :balace_inquiries, :user, null: false, foreign_key: true
  end
end
