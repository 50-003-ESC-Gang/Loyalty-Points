class RemoveTransactionReceiver < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :receiver, :integer
  end
end
