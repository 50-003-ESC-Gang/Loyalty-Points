class FixModels < ActiveRecord::Migration[7.0]
  def change
    remove_column :loyalty_program_data, :loyalty_program_id
    remove_column :loyalty_program_data, :transaction_history
    remove_column :transactions, :loyalty_program_id_id
    remove_column :transactions, :user_id_id

    add_reference :transactions, :loyalty_program_data, index: true
  end
end
