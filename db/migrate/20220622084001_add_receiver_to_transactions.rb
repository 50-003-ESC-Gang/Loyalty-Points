class AddReceiverToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :receiver, :integer
  end
end
