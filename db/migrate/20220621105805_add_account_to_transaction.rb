class AddAccountToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_reference :loyalty_program_data, :accounts, index: true
    # add_foreign_key :loyalty_program_data, :accounts

    add_reference :loyalty_programs, :loyalty_program_data, index: true

    remove_column :transactions, :amount_id
    add_column :transactions, :amount, :decimal
    add_column :transactions, :date, :datetime
    # remove_column :transactions, :status
    add_column :transactions, :status, :integer, default: 0

    # drop_table :account

  end
end
