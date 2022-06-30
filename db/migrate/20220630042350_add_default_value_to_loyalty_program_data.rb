class AddDefaultValueToLoyaltyProgramData < ActiveRecord::Migration[7.0]
  def change
    change_column_default :loyalty_program_data, :points, 0
  end
end
