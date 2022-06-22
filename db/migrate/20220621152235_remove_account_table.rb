class RemoveAccountTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :loyalty_program_data, :account_id
  end
end
