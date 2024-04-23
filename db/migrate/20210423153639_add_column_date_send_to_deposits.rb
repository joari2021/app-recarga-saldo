class AddColumnDateSendToDeposits < ActiveRecord::Migration[6.1]
  def change
    add_column :deposits, :date_send, :datetime
  end
end
