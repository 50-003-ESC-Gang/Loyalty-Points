class AddLoyaltyProgramidToLoyaltyProgramDataModel < ActiveRecord::Migration[7.0]
  def change
    add_column :loyalty_program_data, :loyalty_program_id, :integer
  end
end
