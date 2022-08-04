class AddLoyaltyProgramIdToTrans < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :loyalty_program_id, :string
  end
end
