class CreateLoyaltyProgramData < ActiveRecord::Migration[7.0]
  def change
    create_table :loyalty_program_data do |t|
      t.string :loyalty_program_id
      t.decimal :points
      t.text :transaction_history

      t.timestamps
    end
  end
end
