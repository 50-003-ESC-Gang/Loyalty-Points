class ChangeTimeForLoyaltyPrograms < ActiveRecord::Migration[7.0]
  def change
    change_column :loyalty_programs, :processing_time, :time
  end
end
