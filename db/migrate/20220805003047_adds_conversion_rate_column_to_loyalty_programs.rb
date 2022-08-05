class AddsConversionRateColumnToLoyaltyPrograms < ActiveRecord::Migration[7.0]
  def change
    add_column :loyalty_programs, :conversion_rate, :decimal, default: 1, null: false
  end
end
