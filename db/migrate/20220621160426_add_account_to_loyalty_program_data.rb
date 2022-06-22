class AddAccountToLoyaltyProgramData < ActiveRecord::Migration[7.0]
  def change
    remove_column :loyalty_program_data, :accounts_id

    add_reference :loyalty_program_data, :account, index: true
  end
end
