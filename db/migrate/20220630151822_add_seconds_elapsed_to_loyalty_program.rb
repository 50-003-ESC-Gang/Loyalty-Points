class AddSecondsElapsedToLoyaltyProgram < ActiveRecord::Migration[7.0]
  def change
    add_column :loyalty_programs, :processing_time_seconds, :integer, default: 10_000
    remove_column :loyalty_programs, :processing_time
  end
end
