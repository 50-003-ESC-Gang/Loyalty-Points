class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :loyalty_program_id
      t.string :user_id
      t.datetime :transaction_date
      t.string :transactions_id
      t.decimal :amount
      t.string :status

      t.timestamps
    end
  end
end
