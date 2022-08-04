class ChangeTransactionLoyaltyIdType < ActiveRecord::Migration[7.0]
  def change
    change_column :transactions, :loyalty_program_datum_id, :string
  end
end
